class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_locale

  private

  def set_locale
    if Rails.env == 'test'
      I18n.locale = :en
    elsif I18n.available_locales.include? params[:locale]
      I18n.locale = params[:locale]
    end
    logger.info "ApplicationController@#{__LINE__}#set_locale locale is #{I18n.locale.inspect}"
  end

end
