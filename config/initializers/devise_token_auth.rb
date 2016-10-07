DeviseTokenAuth.setup do |config|
  Rails.application.secrets.facebook_app_secret
  config.change_headers_on_each_request = false
end
