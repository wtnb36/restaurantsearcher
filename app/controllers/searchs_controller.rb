class SearchsController < ApplicationController
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    @records = search_for(@model, @content, @method)
  end

  private

  def search_for(model, content, method)
    if model == 'customer'
      if method == 'perfect'
        Customer.where(nickname: content)
      elsif method == 'partial'
        Customer.where('nickname LIKE ?', '%' + content + '%')
      elsif method == 'forward'
        Customer.where('nickname LIKE ?', content + '%')
      else
        Customer.where('nickname LIKE ?', '%' + content)
      end
    elsif model == 'restaurant'
      if method == 'perfect'
        Restaurant.where(name: content)
      elsif method == 'partial'
        Restaurant.where('name LIKE ?', '%' + content + '%')
      elsif method == 'forward'
        Restaurant.where('name LIKE ?', content + '%')
      else
        Restaurant.where('name LIKE ?', '%' + content)
      end
    end
  end
end
