class Admin::UsersController < Admin::BaseController
  before_action :set_admin_user, only: %i[ show edit update destroy ]

  def index
    @search = Admin::User.all.ransack(params[:q])

    respond_to do |format|
      format.html { @pagy, @admin_users = pagy(@search.result) }
      format.csv  { render csv: @search.result }
    end
  end

  def show
  end

  def new
    @admin_user = Admin::User.new
  end

  def edit
  end

  def create
    @admin_user = Admin::User.new(admin_user_params)

    if @admin_user.save
      redirect_to @admin_user, notice: "User was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @admin_user.update(admin_user_params)
      redirect_to @admin_user, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @admin_user.destroy
    redirect_to admin_users_url, notice: "User was successfully destroyed."
  end

  private
    def set_admin_user
      @admin_user = Admin::User.find(params[:id])
    end

    def admin_user_params
      params.require(:admin_user).permit(:email, :password, :password_confirmation)
    end
end
