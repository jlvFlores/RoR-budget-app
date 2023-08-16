class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:splash_screen]

  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    categories_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
  
  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end
end
