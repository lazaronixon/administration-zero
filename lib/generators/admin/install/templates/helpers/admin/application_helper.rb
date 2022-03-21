module Admin::ApplicationHelper
  include Pagy::Frontend

  def title
    content_for(:title) || Rails.application.class.to_s.split("::").first
  end

  def active_nav_item(controller, actions = %w( index show new edit create update))
    "active" if active_actions?(controller, actions)
  end

  def np(number, options = {})
    number_with_precision number, options
  end

  def nd(number, options = {})
    number_with_delimiter number, options
  end

  def localize(object, **options)
    super(object, **options) if object
  end

  alias :l :localize

  private
    def active_actions?(controller, actions)
      params[:controller].include?(controller) && actions.include?(params[:action])
    end
end
