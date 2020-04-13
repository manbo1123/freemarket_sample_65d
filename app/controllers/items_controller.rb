class ItemsController < ApplicationController
  before_action :set_category, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:edit, :update, :destroy, :purchase, :buy]

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end
  
  def new
    @item = Item.new
    @item.item_imgs.build
  end

    #jsonで親の名前で検索し、紐づく小カテゴリーの配列を取得
  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
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
    else
      render :new
    end
  end

  def update
    if @item.update(item_params[:id])
      redirect_to :root
    else
      render :edit
    end
  end

  def destroy
    @item.destroy(item_params[:id])
    redirect_to :root
  end
  
  def edit
    @item = Item.find(item_params[:id])
  end

  def purchase
    @user = current_user
    @sending_destination = SendingDestination.where(user_id: current_user.id).first
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      redirect_to mypage_cards_new_path
    else
      Payjp.api_key = Rails.application.secrets.payjp_private_key
      customer = Payjp::Customer.retrieve(card.customer_id)
      @card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def buy
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = Rails.application.secrets.payjp_private_key
    Payjp::Charge.create(
    :amount => @item.price, #支払金額を入力（itemテーブル等に紐づけても良い）
    :customer => card.customer_id,
    :currency => 'jpy',
    )
    if @item.update(trading_status: 1, buyer_id: current_user.id)
      redirect_to item_path(@item)
    else
      redirect_to item_path(@item)
    end
    
  end

  private

  #親カテゴリー
  def set_category  
    @category_parent_array = Category.where(ancestry: nil).pluck(:name)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.permit(
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