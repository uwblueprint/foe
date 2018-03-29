class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate

  protected

  def authenticate
    begin
      authenticate_or_request_with_http_token do |token, options|
        @current_user = User.find_by!(token: token)
      end
    rescue ActiveRecord::RecordNotFound
      render json: {}, status: 401
    end
  end
end
