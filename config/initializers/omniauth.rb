Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['APP_KEY'], ENV['APP_SECRET']
  # config.navigational_formats = [:json]
end
