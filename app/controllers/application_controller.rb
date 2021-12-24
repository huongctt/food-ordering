class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ?
    locale : I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def require_admin
    return if current_user.admin?

    flash[:notice] = t 'flash.admin'
    redirect_to root_url
  end
end