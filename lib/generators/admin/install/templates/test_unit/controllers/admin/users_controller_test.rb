require "test_helper"

class Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = sign_in_admin_as(admin_users(:lazaro_nixon))
  end

  test "should get index" do
    get admin_users_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_user_url
    assert_response :success
  end

  test "should create admin_user" do
    assert_difference("Admin::User.count") do
      post admin_users_url, params: { admin_user: { email: "lazaronixon@hey.com", password: "Secret1*3*5*", password_confirmation: "Secret1*3*5*" } }
    end

    assert_redirected_to admin_user_url(Admin::User.last)
  end

  test "should show admin_user" do
    get admin_user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_user_url(@user)
    assert_response :success
  end

  test "should update admin_user" do
    patch admin_user_url(@user), params: { admin_user: { email: @user.email, password: "NewSecret1*3*5*", password_confirmation: "NewSecret1*3*5*" } }
    assert_redirected_to admin_user_url(@user)
  end

  test "should destroy admin_user" do
    assert_difference("Admin::User.count", -1) do
      delete admin_user_url(@user)
    end

    assert_redirected_to admin_users_url
  end
end
