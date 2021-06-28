class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(_resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    if resource == :customer
      new_customer_session_path
    elsif resource == :admin
      new_admin_session_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:
    %i[last_name first_name last_name_kana first_name_kana
       nickname sex birth_date postcode prefecture_code
       address_city address_street address_building phone_number])
  end
end
