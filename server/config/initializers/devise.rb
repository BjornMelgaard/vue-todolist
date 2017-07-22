Devise.setup do |config|
  config.mailer_sender = ENV['MAIL_SENDER']

  # tell devise to not use ActionDispatch::Flash
  # See: http://stackoverflow.com/q/19600905/806956
  config.navigational_formats = [:json]

  # For omniauth https://github.com/lynndylanhurley/devise_token_auth/issues/830
  config.parent_controller = 'ActionController::Base'
end
