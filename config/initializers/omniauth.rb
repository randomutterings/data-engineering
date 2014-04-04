OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, "GZD8uIgd42Ys3PzLSYhsCyJIs", "vcQgMgYgwpyVZXd4b8P69oY1PLfXpcYl1f01uxPTpKTlx8D4AK"
end
