class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  include SessionsHelper

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :display_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :display_name])
  end

  private
  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless user_signed_in?
      store_location
      sign_out current_user
      redirect_to root_url
    end
  end
end
