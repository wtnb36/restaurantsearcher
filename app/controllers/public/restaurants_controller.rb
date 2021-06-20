class Public::RestaurantsController < ApplicationController
  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.save
    redirect_to restaurants_path
  end

  def index
    @restaurants = Restaurant.all
    @customer = current_customer
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @review = Review.new
    @history = History.new
    @my_review = Review.where(customer_id: current_customer.id)
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    redirect_to restaurant_path(@restaurant)
  end

  def deletion_request
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def deletion
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant.update(restaurant_params)
    redirect_to restaurants_path
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(
      :name, :postcode, :prefecture_code,:address_city,
      :address_street, :address_building,:phone_number,
      :business_hours, :holiday, :reason, :is_deleted,
      :tobacco, :introduction, :image)
  end

  def history_params
    params.require(:history).permit(:restaurant_id, :date)
  end

end
