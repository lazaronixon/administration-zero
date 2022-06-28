require "application_system_test_case"

class Admin::UsersTest < ApplicationSystemTestCase
  setup do
    @user = sign_in_admin_as(admin_users(:lazaro_nixon))
  end

  test "visiting the index" do
    visit admin_users_url
    assert_selector "h1", text: "Users"
  end

  test "should create user" do
    visit admin_users_url
    click_on "New user"

    fill_in "Email", with: "lazaronixon@hey.com"
    fill_in "Password", with: "Secret1*3*5*"
    fill_in "Password confirmation", with: "Secret1*3*5*"
    click_on "Create User"

    assert_text "User was successfully created"
  end

  test "should update user" do
    visit admin_user_url(@user)
    click_on "Edit user"

    fill_in "Email", with: @user.email
    fill_in "Password", with: "NewSecret1*3*5*"
    fill_in "Password confirmation", with: "NewSecret1*3*5*"
    click_on "Update User"

    assert_text "User was successfully updated"
  end

  test "should destroy user" do
    visit admin_user_url(@user)
    page.accept_confirm { click_on "Delete user" }

    assert_text "User was successfully destroyed"
  end
end
