class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_category, only: [:new, :edit]
  before_action :set_item, only: [:show, :edit, :update, :destroy, :purchase, :buy]
  before_action :set_card, only: [:purchase, :buy]
  
  def index
    @items = Item.all
    @new_arrival = Item.order(id: "DESC").first(3)

  end

  def show
    @item = Item.find(params[:id])
    @pref = Prefecture.find(@item.prefecture_code)
    @comments = @item.comments.includes(:user).where(item_id: @item.id)
    #コメント追加
    @comment = Comment.new
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
    @category_grandchildren = Category.find(params[:child_id]).children
  end

  def create
    @item = Item.new(item_params)

    brands = Brand.find_or_create_by(name: params[:item][:brand][:name]) 
    @item.update!(brand_id: brands.id)

    if @item.save
      redirect_to item_path(@item)
    else
      render :new
      flash.now[:alert] = "商品出品に失敗しました"
    end
  end

  def update
    brands = Brand.find_or_create_by(name: params[:item][:brand][:name]) 
    @item.update!(brand_id: brands.id)

    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
      flash.now[:alert] = '商品情報の更新に失敗しました'
    end
  end

  def destroy
    if @item.destroy
      redirect_to :root
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

  def purchase
    @sending_destination = SendingDestination.where(user_id: current_user.id).first
    if @card.blank?
      redirect_to mypage_cards_new_path
    else
      Payjp.api_key = Rails.application.secrets.payjp_private_key
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def buy
    Payjp.api_key = Rails.application.secrets.payjp_private_key
    Payjp::Charge.create(
    amount: @item.price,
    customer: @card.customer_id,
    currency: 'jpy',
    )
    if @item.update(buyer_id: current_user.id)
      redirect_to item_path(@item)
    else
      redirect_to item_path(@item)
    end
    
  end

  private

  #親カテゴリー
  def set_category  
    @category_parent_array = Category.where(ancestry: nil)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_card
    @card = Card.where(user_id: current_user.id).first
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

  def correct_user
    @item = Item.find(params[:id])
    if @item.seller_id != current_user.id
      redirect_to item_path(@item), flash: {key: "message"}
    end
  end
end