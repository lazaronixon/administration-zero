class Admin::UserMailer < ApplicationMailer
  def password_reset_provision
    @admin_user = params[:admin_user]
    @signed_id = @admin_user.signed_id(purpose: :password_reset, expires_in: 20.minutes)

    mail to: @admin_user.email, subject: "Reset your password"
  end
end
