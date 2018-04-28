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

  # Replicate logged in state by generating the first auth token
  def sign_in(user)
    @user.create_new_auth_token
  end

  %w(get post put delete).each do |action|
    define_method("authenticated_#{action}") do |url, params={}, headers={}|
      send(action, url, params: params.merge(format: :json), headers: headers.merge!(@user.create_new_auth_token))
    end
  end
end
