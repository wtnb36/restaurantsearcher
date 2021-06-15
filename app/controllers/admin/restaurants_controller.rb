class Admin::RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end
  
  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(is_deleted: false)
    redirect_to admin_restaurant_path(@restaurant)
  end
  
  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to admin_restaurants_path
  end
end
