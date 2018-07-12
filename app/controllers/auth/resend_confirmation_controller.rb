class Auth::ResendConfirmationController < ApplicationController
  def create
    @email = params[:email].downcase
    @user = User.find_by(email: @email)

    if @user && !@user.confirmed?
      @user.send_confirmation_instructions
      render status: 200, json: {
          email: @email,
          message: 'Your request has been received. A new confirmation email has been sent.'
      }.to_json
    elsif @user && @user.confirmed?
      render status: 200, json: {
        email: @email,
        message: 'This account has already been confirmed.'
      }.to_json
    else
      render status: 404, json: {
        email: @email,
        message: 'No user account exists for this email.'
      }.to_json
    end
  end
end
