require "test_helper"

class Admin::SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = admin_users(:lazaro_nixon)
  end

  test "should get new" do
    get admin_sign_in_url
    assert_response :success
  end

  test "should sign in" do
    post admin_sign_in_url, params: { email: @user.email, password: "Secret1*3*5*" }
    assert_redirected_to admin_url

    get admin_url
    assert_response :success
  end

  test "should not sign in with wrong credentials" do
    post admin_sign_in_url, params: { email: @user.email, password: "SecretWrong1*3" }
    assert_redirected_to admin_sign_in_url(email_hint: @user.email)
    assert_equal "That email or password is incorrect", flash[:alert]

    get admin_url
    assert_redirected_to admin_sign_in_url
  end

  test "should sign out" do
    sign_in_admin_as @user

    delete admin_sign_out_url
    assert_redirected_to admin_sign_in_url
  end
end
