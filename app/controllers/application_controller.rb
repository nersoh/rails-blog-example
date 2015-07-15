class ApplicationController < ActionController::Base
 	include Pundit
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def pundit_user
	  current_admin
	end

  def after_sign_in_path_for(resource)
    admin_dashboard_path
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
