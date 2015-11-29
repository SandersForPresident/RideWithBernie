class Profile < ActiveRecord::Base
  before_create :set_uuid
  validates :phone, presence: true
  validates :first_name, presence: true, length: { in: 1..32 }
  validates :location, presence: true, length: { in: 1..64 }
  validates :seats, inclusion: 1..10, if: -> { driver }
  validates :passengers, inclusion: 1..10, if: -> { !driver }
  validate :lookup_phone, if: -> { phone.present? }

  after_save :send_shortlink, if: -> { phone_changed? }

  def contact(other_profile)

    if !other_profile.driver?
      msg = %[
        RideWithBernie: Hi #{other_profile.first_name}! 
        #{first_name} is driving to "#{event_title},"
        coming from "#{location}," and has
        #{seats} seat#{'s' if seats != 1} available.
        You can contact #{first_name} at #{phone} for more details.
        We suggest a phone call to stay safe!
      ]
    else
      msg = %[
        RideWithBernie: Hi #{other_profile.first_name}! 
        #{first_name} needs a ride to "#{event_title},"
        coming from "#{location}," with #{passengers} total passenger#{'s' if passengers != 1}.
        If you can help out, please contact #{first_name} at #{phone} for more details.
        We suggest a phone call to stay safe!
      ]
    end
    msg.gsub!(/[\s\n\r]+/, ' ')

    client = Twilio::REST::Client.new
    client.messages.create(
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: other_profile.phone,
      body: msg
    )

    # Store who we've contacted!
    self.profiles_contacted ||= []
    self.profiles_contacted << other_profile.id
    self.profiles_contacted_will_change!
    self.save
  end

protected

  def lookup_phone
    # Code here mostly from https://github.com/twilio/twilio-ruby/blob/c4ffe31cbd73f15a961d70d134a09adc3cee88b8/docs/usage/lookups.rst

    # set up a client to talk to the Twilio REST API
    @lookups_client = Twilio::REST::LookupsClient.new

    # lookup a number
    number = @lookups_client.phone_numbers.get(self.phone)

    # Re-assign the number to a twilio formatted number
    begin
      self.phone = number.national_format
    rescue Twilio::REST::RequestError => e
      raise e unless e.code == 20404 # ensure this is a 404 error
      self.errors[:phone] << "doesn't look right. Make sure to include an area code."
    end
  end

  def send_shortlink

    url = Bitly.client.shorten("#{ENV['ROOT_URL']}/#/profile/#{self.uuid}/search").short_url

    msg = "RideWithBernie: Thanks for signing up for ridesharing to #{event_title}! You can always get back to your profile here - #{url}"

    client = Twilio::REST::Client.new
    client.messages.create(
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: self.phone,
      body: msg
    )
  end

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end
