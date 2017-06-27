class AuthController < ApplicationController
  skip_before_action :authenticate, only: [:create]

  def create
    if params[:provider] != "facebook"
      return render json: {error: :provider_not_supported}, status: :bad_request
    end

    @current_user = User.from_code(params[:code])
    render json: { token: @current_user.token }
  end
end
