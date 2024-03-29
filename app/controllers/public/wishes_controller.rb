class Public::WishesController < ApplicationController
  before_action :authenticate_customer!

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    wish = current_customer.wishes.new(restaurant_id: @restaurant.id)
    wish.save
  end

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    wish = current_customer.wishes.find_by(restaurant_id: @restaurant.id)
    wish.destroy
  end
end
