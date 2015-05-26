class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  # In case you want to permit additional parameters use below filter
  #before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_role

  def set_current_partner_id
    session[:partner_id]
  end

  def current_role
    current_user.user_role
  end

  def after_sign_in_path_for(user)
    if user.is_active?
       root_url
    else
      sign_out user
      flash.clear
      flash[:error] = "Your account is deactivated, Please contact to the Admin."
       new_user_session_url 
    end
  end

  # protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up) << :username
  # end

end
