class Admin::ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :set_time_zone
  before_action :authenticate

  def set_time_zone
    Time.zone = cookies[:time_zone]
  end

  def authenticate
    if admin_user = Admin::User.find_by_id(session[:admin_user_id])
      Admin::Current.user = admin_user
    else
      redirect_to admin_sign_in_path
    end
  end
end
