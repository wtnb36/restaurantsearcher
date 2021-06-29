class Public::HistoriesController < ApplicationController
  before_action :authenticate_customer!

  def create
    @history = History.new(history_params)
    @history.customer_id = current_customer.id
    @history.save
    redirect_to request.referer
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
