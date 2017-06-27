require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should respond 400 for invalid provider" do
    post "/auth/invalid", params: { code: "1234" }
    assert_response 400
    assert_includes @response.body, "provider_not_supported"
  end

  test "should respond 401 for authentication exception" do
    raises_exception = -> { raise Koala::Facebook::OAuthTokenRequestError.new }

    User.stub :from_code, raises_exception do
      post "/auth/facebook", params: { code: "1234" }
      assert_response 401
      assert_includes @response.body, "oauth_code_unauthorized"
    end
  end

  test "should return successfully with token" do
    User.stub :from_code, @user do
      post "/auth/facebook", params: { code: "1234" }
      assert_response :success
      assert_not_empty response_json['token']
    end
  end
end
