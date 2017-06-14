class AuthController < ApplicationController
  def create
    if params[:provider] != "facebook"
      return render json: {error: :provider_not_supported}, status: bad_request
    end

    user_info, access_token = Omniauth::Facebook.authenticate(params[:code])
    @current_user = User.find_or_create_by!(oauth_token: access_token)
    @current_user.update!(user_info)
  end
end
