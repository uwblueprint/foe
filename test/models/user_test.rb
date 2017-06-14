require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "valid user" do
    user = User.new(oauth_token: "oauth_token_3")
    assert user.valid?
  end

  test "invalid without oauth token" do
    user = User.new()
    refute user.valid?
    assert_not_nil user.errors[:oauth_token]
  end
end
