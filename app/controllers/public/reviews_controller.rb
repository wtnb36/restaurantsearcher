class Public::ReviewsController < ApplicationController
  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @reviews = @restaurant.reviews
  end

  def create
    @review = Review.new(review_params)
    @review.customer_id = current_customer.id
    if @review.save
      redirect_to restaurant_reviews_path
    else
      @restaurant = Restaurant.find(params[:restaurant_id])
      render "public/restaurants/show"
    end
  end

  private

  def review_params
    params.require(:review).permit(:restaurant_id, :score, :content)
  end
end
