require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  test "should return success" do
    stub = { name: "dinah" }, "token-123"

    Omniauth::Facebook.stub :authenticate, stub do
      post "/auth/facebook", params: { code: "1234" }
      assert_response :success
    end
  end

  test "should create a user" do
    assert_difference("User.count", 1) do
      stub = { name: "dinah" }, "token-123"

      Omniauth::Facebook.stub :authenticate, stub do
        post "/auth/facebook", params: { code: "1234" }
      end
    end
  end

  test "should not create a duplicate user" do
    @user = users(:one)
    assert_no_difference("User.count") do
      stub = { name: "new_name" }, @user.oauth_token

      Omniauth::Facebook.stub :authenticate, stub do
        post "/auth/facebook", params: { code: "1234" }
      end
    end

    assert_equal("new_name", @user.reload.name)
  end
end
