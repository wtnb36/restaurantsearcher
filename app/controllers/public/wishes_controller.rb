class Public::WishesController < ApplicationController
  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    wish = current_customer.wishes.new(restaurant_id: restaurant.id)
    wish.save
    redirect_to request.referrer
  end

  def destroy
    restaurant = Restaurant.find(params[:restaurant_id])
    wish = current_customer.wishes.find_by(restaurant_id: restaurant.id)
    wish.destroy
    redirect_to request.referrer
  end
end
