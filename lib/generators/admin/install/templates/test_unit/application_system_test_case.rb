require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  def sign_in_admin_as(user)
    visit admin_sign_in_url
    fill_in :email, with: user.email
    fill_in :password, with: "Secret1*3*5*"
    click_on "Sign in"
    assert_current_path admin_url

    user
  end
end
