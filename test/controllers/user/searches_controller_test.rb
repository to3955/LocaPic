require "test_helper"

class User::SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_searches_index_url
    assert_response :success
  end
end
