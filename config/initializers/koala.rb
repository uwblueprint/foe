Koala.configure do |config|
  config.api_version = 'v2.9'
  config.app_id = Rails.application.secrets.facebook[:app_id]
  config.app_secret = Rails.application.secrets.facebook[:app_secret]
  config.access_token = "#{config.app_id}|#{config.app_secret}"
end
