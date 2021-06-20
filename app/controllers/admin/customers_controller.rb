class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  #admin側のupdateはアカウントの復旧用のみ
  #もし会員情報も編集したければアクションを追加
  def update
    @customer = Customer.find(params[:id])
    @customer.update(is_deleted: false)
    redirect_to admin_customer_path(@customer)
  end
  
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to admin_customers_path
  end
  
  private

  def customer_params
    params.require(:customer).permit(
      :last_name, :first_name, :last_name_kana, :first_name_kana,
      :nickname, :sex, :birth_date, :postcode, :prefecture_code,
      :address_city, :address_street, :address_building,:phone_number, :email)
  end
end
