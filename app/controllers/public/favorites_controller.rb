class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    favorite = current_customer.favorites.new(restaurant_id: @restaurant.id)
    favorite.save
    #redirect_to request.referer
  end

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    favorite = current_customer.favorites.find_by(restaurant_id: @restaurant.id)
    favorite.destroy
    #redirect_to request.referer
  end
end
