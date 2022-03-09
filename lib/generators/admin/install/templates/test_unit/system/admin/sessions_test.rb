require "application_system_test_case"

class Admin::SessionsTest < ApplicationSystemTestCase
  setup do
    @admin_user = admin_users(:lazaro_nixon)
  end

  test "signing in" do
    visit admin_sign_in_url
    fill_in "Email", with: @admin_user.email
    fill_in "Password", with: "Secret1*3*5*"
    click_on "Sign in"

    assert_selector "h1", text: "Admin::Home#index"
  end

  test "signing out" do
    admin_sign_in_as @admin_user
    click_on "Paweł Kuna"
    click_on "Logout"

    assert_selector "h2", text: "Login to your account"
  end
end
