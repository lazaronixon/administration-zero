module Admin::ApplicationHelper
  include Pagy::Frontend

  def title
    content_for(:title) || Rails.application.class.to_s.split("::").first
  end

  def active_nav_item(controller, actions = %w(index show new edit create update))
    active_actions?(controller, actions) ? "active" : ""
  end

  private
    def active_actions?(controller, actions)
      params[:controller].include?(controller) && actions.include?(params[:action])
    end
end
