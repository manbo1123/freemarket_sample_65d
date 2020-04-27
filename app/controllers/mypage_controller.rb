class MypageController < ApplicationController
  before_action :authenticate_user
  
  def index
    @item_exhibition = Item.where(seller_id: current_user.id).where(trading_status: 0).where(buyer_id: nil)
    @item_purchase = Item.where(buyer_id: current_user.id).where(trading_status: [0, 1])
  end

  def logout
  end

end
