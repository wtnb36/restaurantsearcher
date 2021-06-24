class Public::ReviewsController < ApplicationController
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new(review_params)
    @review.customer_id = current_customer.id
    if @review.save
      redirect_to restaurant_path(@restaurant)
    else
      @my_review = Review.where(customer_id: current_customer.id, restaurant_id: @restaurant)
      render "public/restaurants/show"
    end
  end

  def destroy
    Review.find_by(id: params[:id], restaurant_id: params[:restaurant_id]).destroy
    redirect_to request.referer
  end

  private

  def review_params
    params.require(:review).permit(:restaurant_id, :score, :content)
  end
end
