class HomesController < ApplicationController
  def top
    # ランダムで表示 mySQLではRANDへ変更
    #@restaurants = Restaurant.all.order('RANDOM()').limit(5)
    @restaurants = Restaurant.all.order("RAND()").limit(5)
  end

  def about
  end
end
