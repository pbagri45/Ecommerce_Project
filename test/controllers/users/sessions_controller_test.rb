require "test_helper"

class Users::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get users_sessions_new_url
    assert_response :success
  end

  test "should get create" do
    get users_sessions_create_url
    assert_response :success
  end

  test "should get destroy" do
    get users_sessions_destroy_url
    assert_response :success
  end
end
