json.array!(@profiles) do |profile|
  json.extract! profile, :id, :first_name, :driver, :phone, :location, :spots, :plus_ones, :event_id, :event_title, :uuid
  json.url profile_url(profile, format: :json)
end
