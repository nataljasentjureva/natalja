class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    dashboard_path_by_user_role(resource) || welcome_path
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone, :role])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone, :role])
    end

    def dashboard_path_by_user_role(user)
      case user.role
      when 'master'
        master_dashboard_path
      when 'client'
        client_dashboard_path
      end
    end
end