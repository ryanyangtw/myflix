if Rails.env.production? || Rails.env.staging?
  Rack::Timeout.timeout = 10  # seconds
end