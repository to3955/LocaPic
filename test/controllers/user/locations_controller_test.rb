require "test_helper"

class User::LocationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_locations_index_url
    assert_response :success
  end

  test "should get show" do
    get user_locations_show_url
    assert_response :success
  end
end
