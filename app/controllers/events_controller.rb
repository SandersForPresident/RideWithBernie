class EventsController < ApplicationController
# Event isn't a model yet, just a simple ruby class in lib/

  def generate
    event = params[:event]
    title = event[:title].to_s.strip
    if title.blank?
      render json: { message: "Please provide a title" }, status: :unprocessable_entity
    else
      id = Event.generate_id
      url = "#{ENV['ROOT_URL']}/#/instructions?event_id=#{id}&event_title=#{CGI.escape title}"
      shortlink = Bitly.client.shorten(url).short_url
      render json: { id: id, title: title, url: url, shortlink: shortlink }, status: :ok
    end
  end

  def deliver
    event = params[:event]
    if event[:title].present? and event[:shortlink].present? and event[:phone].present?
      begin
        msg = "RideWithBernie - Here's the ridesharing link for your event: #{event[:shortlink]}"
        Twilio::REST::Client.new.messages.create(from: ENV['TWILIO_PHONE_NUMBER'], to: event[:phone], body: msg)
        render json: { success: true }, status: :ok
      rescue Twilio::REST::RequestError => e
        render json: { message: "Sorry, we couldn't text that phone number! Please double check it, or write down the shortlink." }, status: :unprocessable_entity
      end
    else
      render json: { message: "Please provide a phone number" }, status: :unprocessable_entity
    end
  end

end
