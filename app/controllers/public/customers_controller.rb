class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def index
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
    @favorite_restaurants = @customer.favorite_restaurants.page(params[:favorite_page]).per(5)
    @wish_restaurants = @customer.wish_restaurants.page(params[:wish_page]).per(5)
    #お気に入りの中からランダムで1件表示 mySQLではRANDへ変更
    #@random_favorite = @customer.favorite_restaurants.order("RANDOM()").limit(1)
    #@random_wish = @customer.wish_restaurants.order("RANDOM()").limit(1)
    @random_favorite = @customer.favorite_restaurants.order("RAND()").limit(1)
    @random_wish = @customer.wish_restaurants.order("RAND()").limit(1)
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customer_path(current_customer)
    else
      render :edit
    end
  end

  def favorites
    @customer = Customer.find(params[:id])
    @favorite_restaurants = @customer.favorite_restaurants
  end

  def wishes
    @customer = Customer.find(params[:id])
    @wish_restaurants = @customer.wish_restaurants
  end

  def unsubscribe
    @customer = current_customer
  end

  def withdrawal
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(
      :last_name, :first_name, :last_name_kana, :first_name_kana,
      :nickname, :sex, :birth_date, :postcode, :prefecture_code,
      :address_city, :address_street, :address_building,:phone_number,
      :email, :is_deleted)
  end
end
