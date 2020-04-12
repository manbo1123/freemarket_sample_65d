class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_category, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_item, only: [:edit, :update, :destroy]

  def index
    @items = Item.all
  end

  def show
  end
  
  def new
    @item = Item.new
    @item.item_imgs.build
  end

    #jsonで親の名前で検索し、紐づく小カテゴリーの配列を取得
  def get_category_children
    @category_children = Category.find(params[:parent_name]).children
  end

    #jsonで子カテゴリーに紐づく孫カテゴリーの配列を取得
  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end
  
  def create
    @item = Item.new(item_params)
    @item.build_brand(name: params[:item][:brand][:name])
    if @item.save
      redirect_to :root
      flash[:success] = "商品出品が完了しました"
    else
      render :new
      flash[:danger] = "商品出品に失敗しました"
    end
  end

  def update
    @item.build_brand(name: params[:item][:brand][:name])
    if @item.update(item_params)
      redirect_to :root
      flash[:success] = "商品情報を更新しました"
    else
      render :edit
      flash.now[:alert] = '商品情報の更新に失敗しました'
    end
  end

  def destroy
    if @item.destroy
      redirect_to :root
      flash[:success] = "商品情報を削除しました"
    else
      render :show
    end
  end
  
  def edit
    #カテゴリーデータ取得
    @grandchild_category = @item.category
    @child_category = @grandchild_category.parent 
    @category_parent = @child_category.parent

    #カテゴリー一覧を作成
    @category = Category.find(params[:id])
    # 紐づく孫カテゴリーの親（子カテゴリー）の一覧を配列で取得
    @category_children = @item.category.parent.parent.children
    # 紐づく孫カテゴリーの一覧を配列で取得
    @category_grandchildren = @item.category.parent.children
  end

  private

  #親カテゴリー
  def set_category  
    @category_parent_array = Category.where(ancestry: nil)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(
      :name,
      :item_condition_id,
      :introduction,
      :price,
      :prefecture_code,
      :trading_status,
      :postage_payer_id,
      :size_id,
      :preparation_day_id,
      :postage_type_id,
      :category_id,
      item_imgs_attributes: [:src, :_destroy, :id]
      ).merge(seller_id: current_user.id, trading_status: 0)
  end
end