require "pagy/extras/bootstrap"

module Admin::ApplicationHelper
  include Pagy::Frontend

  def title
    content_for(:title) || Rails.application.class.to_s.split("::").first
  end

  def active_nav_item(*names)
    names.include?(controller_path) ? "active" : ""
  end
end
