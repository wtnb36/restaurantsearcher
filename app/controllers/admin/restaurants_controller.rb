class Admin::RestaurantsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  # admin側のupdateはアカウントの復旧用のみ
  # もし店舗情報も編集したければアクションを追加
  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(is_deleted: false, reason: '')
    redirect_to admin_restaurant_path(@restaurant)
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to admin_restaurants_path
  end
end
