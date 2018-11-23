# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :verify_authenticity_token
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
  end

  def check_user_is_admin
    unless current_user.admin?
      # flash[:error] = 'You must be logged in as a admin access this section'
      redirect_to user_path(current_user)
    end
  end

end
