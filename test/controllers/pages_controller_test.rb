require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get confirm" do
    get pages_confirm_url
    assert_response :success
  end
end
