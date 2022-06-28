require "test_helper"

class Admin::PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = admin_users(:lazaro_nixon)
    @sid = @user.signed_id(purpose: :password_reset, expires_in: 20.minutes)
    @sid_exp = @user.signed_id(purpose: :password_reset, expires_in: 0.minutes)
  end

  test "should get new" do
    get new_admin_password_reset_url
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_password_reset_url(token: @sid)
    assert_response :success
  end

  test "should send a password reset email" do
    assert_enqueued_email_with Admin::UserMailer, :password_reset, args: { user: @user } do
      post admin_password_reset_url, params: { email: @user.email }
    end

    assert_redirected_to admin_sign_in_url
  end

  test "should not send a password reset email to a nonexistent email" do
    assert_no_enqueued_emails do
      post admin_password_reset_url, params: { email: "invalid_email@hey.com" }
    end

    assert_redirected_to new_admin_password_reset_url
    assert_equal "Sorry, we didn't recognize that email address", flash[:alert]
  end

  test "should update password" do
    patch admin_password_reset_url, params: { token: @sid, password: "Secret6*4*2*", password_confirmation: "Secret6*4*2*" }
    assert_redirected_to admin_sign_in_url
  end

  test "should not update password with expired token" do
    patch admin_password_reset_url, params: { token: @sid_exp, password: "Secret6*4*2*", password_confirmation: "Secret6*4*2*" }

    assert_redirected_to new_admin_password_reset_url
    assert_equal "That password reset link is invalid", flash[:alert]
  end
end
