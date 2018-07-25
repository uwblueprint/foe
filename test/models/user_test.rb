require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_valid_user
    user = User.new(email: "foo@bar.com", password: "password")
    assert user.valid?
  end
end
