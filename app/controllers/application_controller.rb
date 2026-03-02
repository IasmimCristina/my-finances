class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes


  # Authorization with Pundit


  include Pundit::Authorization

  # Ensure user is logged in for all actions
  before_action :authenticate_user!

  # Raise error if user tries unauthorized action
  # (Will show error page instead of silent deny)
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  # Helper methods for views


  helper_method :policy

  private

  def user_not_authorized
    redirect_to root_path, alert: "You are not authorized to perform this action."
  end
end
