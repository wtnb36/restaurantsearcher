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
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    redirect_to restaurant_path(@restaurant)
  end
  
  private

  def restaurant_params
    params.require(:restaurant).permit(
      :name, :postcode, :prefecture_code,:address_city,
      :address_street, :address_building,:phone_number,
      :business_hours, :holiday)
  end
  
  def history_params
    params.require(:history).permit(:restaurant_id, :date)
  end
  
end
