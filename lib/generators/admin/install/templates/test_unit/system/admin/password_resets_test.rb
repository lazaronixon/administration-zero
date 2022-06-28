require "application_system_test_case"

class Admin::PasswordResetsTest < ApplicationSystemTestCase
  setup do
    @user = admin_users(:lazaro_nixon)
    @sid = @user.signed_id(purpose: :password_reset, expires_in: 20.minutes)
  end

  test "sending a password reset email" do
    visit admin_sign_in_url
    click_on "I forgot password"

    fill_in "Email", with: @user.email
    click_on "Send me new password"

    assert_text "Check your email for reset instructions"
  end

  test "updating password" do
    visit edit_admin_password_reset_url(token: @sid)

    fill_in "New password", with: "Secret6*4*2*"
    fill_in "Confirm new password", with: "Secret6*4*2*"
    click_on "Save changes"

    assert_text "Your password was reset successfully. Please sign in"
  end
end
