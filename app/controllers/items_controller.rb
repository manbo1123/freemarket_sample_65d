class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end
  
  def new
    @item = Item.new

    #親カテゴリー
    @category_parent_array = Category.where(ancestry: nil).pluck(:name)
  end
  
  def create
    Item.create(item_params)
    redirect_to root_path
  end
  
  def edit
  end
end