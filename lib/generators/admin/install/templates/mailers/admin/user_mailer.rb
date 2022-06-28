class Admin::UserMailer < Admin::ApplicationMailer
  def password_reset
    @user = params[:user]
    @signed_id = @user.signed_id(purpose: :password_reset, expires_in: 20.minutes)

    mail to: @user.email, subject: "Reset your password"
  end
end
