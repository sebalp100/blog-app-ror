class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name photo])
  end

  def after_sign_up_path_for(_resource)
    new_user_confirmation_path
  end

  private

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end
end
