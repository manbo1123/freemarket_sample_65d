class Mypage::PurchasesController < ApplicationController
  before_action :authenticate_user

  def index
    if request.fullpath == "/mypage/purchases/dealing"
      @item_purchase = Item.where(buyer_id: current_user.id).where(trading_status: [0, 1])
    else request.fullpath == "/mypage/purchases/closed"
      @item_purchase = Item.where(buyer_id: current_user.id).where(trading_status: 2)
    end
  end

  def set_purchase
    if params[:id] == "0"
      purchaseIds = Item.where(buyer_id: current_user.id).where(trading_status: [0, 1]).pluck(:id)
    else
      purchaseIds = Item.where(buyer_id: current_user.id).where(trading_status: 2).pluck(:id)
    end
    @purchases = []
    purchaseIds.each do |purchaseId|
      purchase = Item.find(purchaseId)
      @purchases << purchase
    end
  end

  def arriving
    @item_arriving = Item.find(params[:id])
    if @item_arriving.update(trading_status: 2)
    else
      flash.now[:alert] = @item_arriving.errors.full_messages
    end
  end
end
