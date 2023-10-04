require "test_helper"

class User::ReplyesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_replyes_create_url
    assert_response :success
  end

  test "should get destroy" do
    get user_replyes_destroy_url
    assert_response :success
  end
end
