class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :role
    devise_parameter_sanitizer.for(:account_update) << :role
  end

end
