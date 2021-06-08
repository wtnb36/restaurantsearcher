class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:
    [:last_name, :first_name, :last_name_kana, :first_name_kana,
     :nickname, :sex, :birth_date, :postcode, :prefecture_code,
     :address_city, :address_street, :address_building,:phone_number])
  end
end
