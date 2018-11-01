class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end
  def check_user_is_admin
    unless current_user.admin?
      flash[:error] = "You must be logged in as a admin access this section"
      redirect_back(fallback_location: home_index_path) # halts request cycle
    end
  end  
end
