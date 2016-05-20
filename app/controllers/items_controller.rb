class ItemsController < ApplicationController
  before_action :logged_in_user , except: [:show]
  before_action :set_item, only: [:show]

  def new
    if params[:q]
      response = RakutenWebService::Ichiba::Item.search(keyword: params[:q],imageFlag: 1,)
      @items = response.first(1)
      #binding.pry
    end
  end

  def show
  end
  
  def create
    
  end
  
  def destroy
  end


  private
  def set_item
    @item = Item.find(params[:id])
  end
end
