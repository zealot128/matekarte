Geocoder.configure(
  timeout: 10,
  lookup: :nominatim,
  # cache: Redis.new,
  units: :km,
  http_headers: { "User-Agent" => "matekarte.org" }
)

if Rails.env.production?
  Geocoder.config[:cache] = Redis.new
else
  Geocoder.config[:cache] = {}
end
