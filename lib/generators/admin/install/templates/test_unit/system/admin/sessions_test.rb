require "application_system_test_case"

class Admin::SessionsTest < ApplicationSystemTestCase
  setup do
    @user = admin_users(:lazaro_nixon)
  end

  test "signing in" do
    visit admin_sign_in_url
    fill_in "Email", with: @user.email
    fill_in "Password", with: "Secret1*3*5*"
    click_on "Sign in"

    assert_selector "h1", text: "Admin::Home#index"
  end

  test "signing out" do
    sign_in_admin_as @user
    click_on "Paweł Kuna"
    click_on "Logout"

    assert_selector "h1", text: "Login to your account"
  end
end
