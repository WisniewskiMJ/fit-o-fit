Google::Maps.configure do |config|
  config.authentication_mode = Google::Maps::Configuration::API_KEY
  config.api_key = ENV['GMAPS_API_KEY']
  config.default_language = :pl
end
