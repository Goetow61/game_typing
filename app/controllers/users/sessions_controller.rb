# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    
    # ログインしないでタイピングしていた場合に、キャッシュしておいた
    # タイピング結果をログイン時に登録する。（新規登録時にもsign_inが走るので
    # registrations_controllerは触る必要ない）
    if session[:result] != nil
      # cookieの有効期限が切れていなければ登録
      if session[:result_expires_at] > Time.now
        @result = Result.new(session[:result])
        @result.user_id = resource.id
        @result.save
      end
      # cookieの破棄
      session[:result] = nil
      session[:result_expires_at] = nil
    end
    
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
