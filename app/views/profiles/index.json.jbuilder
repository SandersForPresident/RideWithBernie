json.array!(@profiles) do |profile|
  json.extract! profile, :id, :first_name, :driver, :phone, :spots, :plus_ones, :uuid
  json.url profile_url(profile, format: :json)
end
