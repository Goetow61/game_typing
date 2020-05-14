class ApplicationController < ActionController::Base
  # CSRF対策。Railsで生成されるすべてのフォームとAjaxリクエストにセキュリティトークンが自動的に
  # 含まれる。セキュリティトークンがマッチしない場合には例外がスローされる。
  protect_from_forgery with: :exception
  
  # deviseに関わる画面表示の時にパラメータを許可する
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
  end
end
