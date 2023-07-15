class Admin::BaseController < ActionController::Base
  include Pagy::Backend

  around_action :set_time_zone
  before_action :authenticate

  private
    def set_time_zone
      Time.use_zone(cookies[:time_zone]) { yield }
    end

    def authenticate
      if user = Admin::User.find_by_id(session[:admin_user_id])
        Admin::Current.user = user
      else
        redirect_to admin_sign_in_path
      end
    end
end
