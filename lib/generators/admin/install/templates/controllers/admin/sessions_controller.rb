class Admin::SessionsController < Admin::BaseController
  skip_before_action :authenticate, only: %i[ new create ]

  layout "admin/authentication"

  def new
    @user = Admin::User.new
  end

  def create
    if user = Admin::User.authenticate_by(email: params[:email], password: params[:password])
      session[:admin_user_id] = user.id; redirect_to(admin_path)
    else
      redirect_to admin_sign_in_path(email_hint: params[:email]), alert: "That email or password is incorrect"
    end
  end

  def destroy
    session[:admin_user_id] = nil; redirect_to admin_sign_in_path
  end
end
