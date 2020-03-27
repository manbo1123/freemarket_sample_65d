class CardsController < ApplicationController
  require "payjp"
  
  #Cardの新規作成
  def new
    card = Card.where(user_id: current_user.id)
    redirect_to action: "show" if card.present?
  end

  #payjpとCardのデータベース作成
  def pay
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(card: params['payjp-token'])
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end
    end
  end

  #CardのデータをPayjpに送って情報を取り出す
  def show
    card = Card.where(user_id: current_user.id).first
    if card.present?
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      customer = Payjp::Customer.retrieve(card.customer_id)
      @card_information = customer.cards.retrieve(card.card_id)
    else
      redirect_to action: "new" 
    end
  end

  #PayjpとCardデータベースを削除
  def delete
    card = Card.where(user_id: current_user.id).first
    if card.present?
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: "new"
  end

  #item購入
  # def buy
  #   card = Card.where(user_id: current_user.id).first
  #     if card.present?
  #       @item = Item.find(params[:product_id])
  #       card = current_user.credit_card
  #       Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
  #       Payjp::Charge.create(
  #       amount: 500,  #@item.price
  #       customer: card.customer_id,
  #       currency: 'jpy',
  #       )
  #       if @item.update(status: 1, buyer_id: current_user.id)
  #         redirect_to item_path
  #       else
  #         redirect_to item_path
  #       end
  #     else
  #       redirect_to action: "new"
  #     end
  # end

end
