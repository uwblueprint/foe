class AuthController < ApplicationController
  skip_before_action :authenticate, only: [:create]

  def create
    if params[:provider] != "facebook"
      return render json: { error: :provider_not_supported }, status: :bad_request
    end

    begin
      @current_user = User.from_code(params[:code])
      render json: { token: @current_user.token }
    rescue
      return render json: { error: :oauth_code_unauthorized }, status: 401
    end
  end
end
