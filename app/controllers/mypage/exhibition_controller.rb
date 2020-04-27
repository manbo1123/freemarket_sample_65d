class Mypage::ExhibitionController < ApplicationController
  before_action :authenticate_user

  def index
    if request.fullpath == "/mypage/exhibition/selling"
      @item_exhibition = @item_exhibition = Item.where(seller_id: current_user.id).where(trading_status: 0).where(buyer_id: nil)
    elsif request.fullpath == "/mypage/exhibition/dealing"
      @item_exhibition = Item.where(seller_id: current_user.id).where(trading_status: [0, 1]).where.not(buyer_id: nil)
    else 
      @item_exhibition = Item.where(seller_id: current_user.id).where(trading_status: 2).where.not(buyer_id: nil)
    end
  end

  def set_exhibition
    if params[:id] == "0"
      exhibitionIds = Item.where(seller_id: current_user.id).where(trading_status: 0).where(buyer_id: nil).pluck(:id)
    elsif params[:id] == "1"
      exhibitionIds = Item.where(seller_id: current_user.id).where(trading_status: [0, 1]).where.not(buyer_id: nil).pluck(:id)
    else
      exhibitionIds = Item.where(seller_id: current_user.id).where(trading_status: 2).where.not(buyer_id: nil).pluck(:id)
    end
    @exhibitions = []
    exhibitionIds.each do |exhibitionId|
      exhibition = Item.find(exhibitionId)
      @exhibitions << exhibition
    end
  end

  def shipping
    @item_shipping = Item.find(params[:id])
    if @item_shipping.update(trading_status: 1)
    else
      flash.now[:alert] = @user.errors.full_messages
    end
  end
end
