class Mypage::FavoritesController < ApplicationController
  before_action :authenticate_user

  def index
    if request.fullpath == "/mypage/favorite/selling"
      @myfavorites = Favorite.where(user_id: current_user.id)
      @favoritesitem_id = @myfavorites.pluck(:item_id)
      @favorite_list = Item.find(@favoritesitem_id).where(buyer_id: nil)
    elsif request.fullpath == "/mypage/favorite/closed"
      @myfavorites = Favorite.where(user_id: current_user.id)
      @favoritesitem_id = @myfavorites.pluck(:item_id)
      @favorite_list = Item.find(@favoritesitem_id).where.not(buyer_id: nil)
    end
  end

  def set_favorite
    # if params[:id] == "0"
    #   favoriteIds = Item.where(seller_id: current_user.id).where(trading_status: 0).where(buyer_id: nil).pluck(:id)
    # elsif params[:id] == "1"
    #   exhibitionIds = Item.where(seller_id: current_user.id).where(trading_status: [0, 1]).where.not(buyer_id: nil).pluck(:id)
    # else
    #   exhibitionIds = Item.where(seller_id: current_user.id).where(trading_status: 2).where.not(buyer_id: nil).pluck(:id)
    # end
    @favorites = []
      @myfavorites = Favorite.where(user_id: current_user.id)
      @favoritesitem_id = @myfavorites.pluck(:item_id)
      @favorite_list = Item.find(@favoritesitem_id)
      @favorites << favorites
  end

end