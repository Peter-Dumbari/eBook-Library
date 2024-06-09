class ApplicationController < ActionController::API
    # before_action :authenticate_user!
  before_action :update_allowed_parameters, if: :devise_controller?
 
  rescue_from CanCan::AccessDenied do |exception|
    render json: { message: exception, status: 'authorization_failed' }, status: :unauthorized
  end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation, :role)
    end
  end
end
