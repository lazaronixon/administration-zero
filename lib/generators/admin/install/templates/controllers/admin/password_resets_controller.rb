class Admin::PasswordResetsController < Admin::ApplicationController
  skip_before_action :authenticate

  before_action :set_admin_user, only: %i[ edit update ]

  layout "admin/authentication"

  def new
  end

  def edit
  end

  def create
    if @admin_user = Admin::User.find_by(email: params[:email])
      Admin::UserMailer.with(admin_user: @admin_user).password_reset_provision.deliver_later
      redirect_to admin_sign_in_path, notice: "Check your email for reset instructions"
    else
      redirect_to new_admin_password_reset_path, alert: "Sorry, we didn't recognize that email address"
    end
  end

  def update
    if @admin_user.update(admin_user_params)
      redirect_to admin_sign_in_path, notice: "Your password was reset successfully. Please sign in"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_admin_user
      @admin_user = Admin::User.find_signed!(params[:token], purpose: :password_reset)
    rescue
      redirect_to new_admin_password_reset_path, alert: "That password reset link is invalid"
    end

    def admin_user_params
      params.permit(:password, :password_confirmation)
    end
end
