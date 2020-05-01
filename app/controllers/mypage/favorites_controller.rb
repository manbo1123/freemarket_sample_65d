class Mypage::FavoritesController < ApplicationController
  before_action :authenticate_user

  def index
    @myfavorites = Favorite.where(user_id: current_user.id)
    @favoritesitem_id = @myfavorites.pluck(:item_id)
    @favorite_list = Item.find(@favoritesitem_id)

    @fa = Favorite.where(item_id: @favoritesitem_id)
  end
end