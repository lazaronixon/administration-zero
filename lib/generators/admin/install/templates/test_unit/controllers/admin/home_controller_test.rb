require "test_helper"

class Admin::HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = admin_sign_in_as(admin_users(:lazaro_nixon))
  end

  test "should get index" do
    get admin_url
    assert_response :success
  end
end
