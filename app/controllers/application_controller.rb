class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :authenticate_user!
	# before_action :configure_permitted_parameters, if: :devise_controller?

	private


  # def configure_permitted_parameters
  #      devise_parameter_sanitizer.permit(:invite, keys: [:email,:firstname, :lastname, :lastname_prefix, :customer_id, :sex, :return_path, :id, roles_attributes: [:id, :name, :selected]])
  # end
end
