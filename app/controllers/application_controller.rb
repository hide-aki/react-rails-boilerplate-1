class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  prepend_view_path Rails.root.join('frontend')
  # Show cancan authorize message
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_back fallback_location: root_path, alert: exception.message }
      format.js { head :forbidden, content_type: 'text/html' }
    end
  end
end
