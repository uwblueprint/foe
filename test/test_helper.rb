require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'minitest/autorun'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def response_json
    JSON.parse(response.body)
  end

  def request_token(user)
    ActionController::HttpAuthentication::Token.encode_credentials(user.token)
  end

  %w(get post put delete).each do |action|
    define_method("authenticated_#{action}") do |url, params=nil|
      send(action, url, params: params, as: :json, headers: { 'HTTP_AUTHORIZATION': request_token(@user) })
    end
  end
end
