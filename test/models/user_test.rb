require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "valid user" do
    user = User.new(oauth_token: "oauth_token_3")
    assert user.valid?
  end

  def test_from_code
    assert_difference("User.count", 1) do
      user_stub = { "id": "1", "name": "Dinah" }
      access_token_info_stub = { "data": { "is_valid": true } }

      Facebook.stub :access_token_info, access_token_info_stub do
        Facebook.stub :user_hash, user_stub do
          User.from_code("1234")
        end
      end
    end
  end

  def test_from_code_with_invalid_code
    assert_raises Koala::Facebook::AuthenticationError do
      access_token_info_stub = {
        "data": {
          "error": {
            "code": 190,
            "message": "Invalid OAuth access token."
          },
          "is_valid": false
        }
      }

      Facebook.stub :access_token_info, access_token_info_stub do
        User.from_code("1234")
      end
    end
  end

  def test_from_code_with_existing_user
    @user = users(:one)

    assert_no_difference("User.count") do
      user_stub = { "id" => @user.uid, "name" => "New Name" }

      Facebook.stub :user_hash, user_stub do
        existing_user = User.from_code("1234")
        assert_equal "New Name", existing_user.name
      end
    end
  end
end
