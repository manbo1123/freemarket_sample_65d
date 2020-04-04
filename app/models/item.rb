class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :item_imgs, dependent: :destroy
  belongs_to :category
  belongs_to :brand, optional: true
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User", optional: true
  belongs_to_active_hash :size
  belongs_to_active_hash :item_condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :preparation_day
  belongs_to_active_hash :postage_type
  accepts_nested_attributes_for :item_imgs, allow_destroy: true

  enum trading_status: {selling: 0, during_deal: 1, deal_closed: 2}

end
