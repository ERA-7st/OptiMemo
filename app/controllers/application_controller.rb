class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def user_logged_in?
    redirect_to root_path unless user_signed_in?
  end

  def before_sign_up?
    redirect_to user_home_top_path if user_signed_in?
  end

  def after_sign_in_path_for(resource)
    user_home_top_path
  end

  protected

  def configure_permitted_parameters
    added_attrs = [ :email, :name, :password, :password_confirmation ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end

end
