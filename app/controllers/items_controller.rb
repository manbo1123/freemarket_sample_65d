class ItemsController < ApplicationController
  def index
  end

  def show
  end
  
  def new
    @item = Item.new

    #親カテゴリー
    @category_parent_array = Category.where(ancestry: nil).pluck(:name)
  end
  
  def create
  end
  
  def edit
  end
end