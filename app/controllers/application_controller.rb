class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  # i18n
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # link_toなどのすべてのURLにlocaleパラメータを設定するようにする
  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end
end
