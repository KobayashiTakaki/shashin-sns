class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

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
