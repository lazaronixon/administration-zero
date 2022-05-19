class Admin::SessionsController < Admin::BaseController
  skip_before_action :authenticate, only: %i[ new create ]

  layout "admin/authentication"

  def new
    @admin_user = Admin::User.new
  end

  def create
    @admin_user = Admin::User.find_by(email: params[:email])

    if @admin_user && @admin_user.authenticate(params[:password])
      session[:admin_user_id] = @admin_user.id; redirect_to(admin_path)
    else
      redirect_to admin_sign_in_path(email_hint: params[:email]), alert: "That email or password is incorrect"
    end
  end

  def destroy
    session[:admin_user_id] = nil; redirect_to admin_sign_in_path
  end
end
