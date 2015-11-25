class Profile < ActiveRecord::Base
  before_create :set_uuid
  validates :phone, presence: true
  validates :first_name, presence: true
  validates :location, presence: true
  validates :spots, inclusion: 0..10, if: -> { driver }
  validates :plus_ones, inclusion: 0..10, if: -> { !driver }
  validate :lookup_phone, if: -> { phone.present? }

protected

  def lookup_phone
    require 'twilio-ruby'
    # Code here mostly from https://github.com/twilio/twilio-ruby/blob/c4ffe31cbd73f15a961d70d134a09adc3cee88b8/docs/usage/lookups.rst

    # set up a client to talk to the Twilio REST API
    @lookups_client = Twilio::REST::LookupsClient.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

    # lookup a number
    number = @lookups_client.phone_numbers.get(self.phone)

    # Re-assign the number to a twilio formatted number
    begin
      self.phone = number.national_format
    rescue Twilio::REST::RequestError => e
      raise e unless e.code == 20404 # ensure this is a 404 error
      self.errors[:phone] << "doesn't look right. Make sure to include a zip code"
    end
  end

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end
