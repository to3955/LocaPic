require "test_helper"

class User::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get user_users_show_url
    assert_response :success
  end

  test "should get edit" do
    get user_users_edit_url
    assert_response :success
  end

  test "should get update" do
    get user_users_update_url
    assert_response :success
  end

  test "should get confirm" do
    get user_users_confirm_url
    assert_response :success
  end

  test "should get out" do
    get user_users_out_url
    assert_response :success
  end
end
