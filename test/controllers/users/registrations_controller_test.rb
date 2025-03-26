require "test_helper"

class Users::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get users_registrations_new_url
    assert_response :success
  end

  test "should get create" do
    get users_registrations_create_url
    assert_response :success
  end
end
