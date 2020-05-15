# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  def new_guest
    user = User.guest
    sign_in user
    result(user.id)
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  # POST /resource/sign_in
  def create
    sign_in(resource_name, resource)
    result(resource.id)
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # ログインしないでタイピングしていた場合に、キャッシュしておいた
  # タイピング結果をログイン時に登録する。（新規登録時にもsign_inが走るので
  # registrations_controllerは触る必要ない）
  def result(userID)
    if session[:result] != nil
      # cookieの有効期限が切れていなければ登録
      if session[:result_expires_at] > Time.now
        @result = Result.new(session[:result])
        @result.user_id = userID
        @result.save
      end
      # cookieの破棄
      session[:result] = nil
      session[:result_expires_at] = nil
    end
  end
  
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
