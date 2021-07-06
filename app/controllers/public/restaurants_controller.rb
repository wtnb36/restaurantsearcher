class Public::RestaurantsController < ApplicationController
  before_action :authenticate_customer!

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      @restaurant.portraits.each do |portrait|
        tag_names = Vision.get_image_data(portrait.blob.key)
        tag_names.each do |tag_name|
          tag = Tag.find_by(restaurant_id: @restaurant, name: tag_name)
          if tag.blank?
            @restaurant.tags.create(name: tag_name)
          end
        end
      end
      redirect_to restaurants_path
    else
      render :new
    end
  end

  def index
    @restaurants = Restaurant.all.page(params[:page]).per(10)
    @customer = current_customer
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @review = Review.new
    @history = History.new
    @my_review = Review.where(customer_id: current_customer.id, restaurant_id: @restaurant)
    @review_index = Review.where(restaurant_id: @restaurant).page(params[:page]).per(5)
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if params[:restaurant][:portrait_ids]
      params[:restaurant][:portrait_ids].each do |portrait_id|
        portrait = @restaurant.portraits.find(portrait_id)
        portrait.purge
      end
    end
    if @restaurant.update(restaurant_params)
      @restaurant.tags.delete_all
      @restaurant.portraits.each do |portrait|
        tag_names = Vision.get_image_data(portrait.blob.key)
        tag_names.each do |tag_name|
          tag = Tag.find_by(restaurant_id: @restaurant, name: tag_name)
          if tag.blank?
            @restaurant.tags.create(name: tag_name)
          end
        end
      end
      redirect_to restaurant_path(@restaurant)
    else
      render :edit
    end
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
      :name, :postcode, :prefecture_code, :address_city,
      :address_street, :address_building, :phone_number,
      :business_hours, :holiday, :reason, :is_deleted,
      :tobacco, :introduction, :image, portraits: []
    )
  end

  def history_params
    params.require(:history).permit(:restaurant_id, :date)
  end
end
