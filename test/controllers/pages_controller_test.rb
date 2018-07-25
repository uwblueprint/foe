require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get confirm" do
    get confirm_url
    assert_response :success
  end
end
