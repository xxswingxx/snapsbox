class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!  
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_team
  	@current_team ||= current_user.team
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:edit) do |u|
      u.permit(:name, :email, :password, :password_confirmation, :current_password)
    end
  end
  
  private
  def after_sign_out_path_for(resource_or_scope)
    new_session_path(resource_or_scope)
  end
end