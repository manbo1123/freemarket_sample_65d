class ItemsController < ApplicationController
  def index
    
  end
  
  def new
    @item = Item.new

    #親カテゴリー
    @category_parent_array = ["選択してください"]   #親カテゴリーの初期値(配列)
    Category.where(ancestry: nil).each do |parent|  #テーブルから、親のみ取り出して、配列化
      @category_parent_array << parent.name
    end
  end
  
  def create
  end
  
  def edit
  end
end