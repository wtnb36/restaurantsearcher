class Public::FavoritesController < ApplicationController
  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    favorite = current_customer.favorites.new(restaurant_id: restaurant.id)
    favorite.save
    redirect_to request.referrer
  end

  def destroy
    restaurant = Restaurant.find(params[:restaurant_id])
    favorite = current_customer.favorites.find_by(restaurant_id: restaurant.id)
    favorite.destroy
    redirect_to request.referrer
  end
end
