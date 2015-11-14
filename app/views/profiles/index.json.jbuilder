json.array!(@profiles) do |profile|
  json.extract! profile, :id, :first_name, :driver, :phone, :location, :spots, :plus_ones, :eventId, :eventTitle, :uuid
  json.url profile_url(profile, format: :json)
end
