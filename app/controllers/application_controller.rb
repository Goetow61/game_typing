class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # ログイン済ユーザーのみアクセスを許可する。
  # できれば、ユーザー登録せずともタイピングできるようにしたい。実装変える時に無効にすること。
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
end
