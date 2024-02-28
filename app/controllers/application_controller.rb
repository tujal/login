class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    protected

    def configure_permitted_parameters
         devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username,:first_name, :last_name, :email, :password, :password_confirmation)}
         devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :current_password, :password_confirmation)} 
         devise_parameter_sanitizer.permit(:sign_in,
         keys: [:email, :password, :password_confirmation])
    end

    def after_sign_out_path_for(resource_or_scope)
        new_user_session_path
    end
end