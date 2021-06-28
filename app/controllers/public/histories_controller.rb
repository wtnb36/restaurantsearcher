class Public::HistoriesController < ApplicationController
  before_action :authenticate_customer!

  def create
    @history = History.new(history_params)
    @history.customer_id = current_customer.id
    if @history.save
      redirect_to request.referer
    #else
      #@restaurant = Restaurant.find(params[:restaurant_id])
      #render "public/restaurants/show"
    end
  end

  def index
    @histories = current_customer.histories
  end

  def destroy
    @history = History.find(params[:id]).destroy
    redirect_to histories_path
  end

  private

  def history_params
    params.require(:history).permit(:restaurant_id, :date)
  end
end
