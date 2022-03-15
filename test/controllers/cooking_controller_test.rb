require "test_helper"

class CookingControllerTest < ActionDispatch::IntegrationTest
  test "should get _sessions" do
    get cooking__sessions_url
    assert_response :success
  end
end
