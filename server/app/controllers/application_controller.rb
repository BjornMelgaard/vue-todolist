class ApplicationController < ActionController::Base
  include Knock::Authenticable
  include Pundit

  protect_from_forgery with: :null_session

  def set_locale
    I18n.locale = params[:locale] || request.headers['locale'] || I18n.default_locale
  end
end
