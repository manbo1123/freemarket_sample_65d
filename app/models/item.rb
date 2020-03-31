class Item < ApplicationRecord
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :favorites
  has_many :itemimgs, dependent: :destroy
  has_one :user_evaluation
  belongs_to_active_hash :size
  belongs_to_active_hash :item_condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :preparation_day
  belongs_to_active_hash :postage_type
  belongs_to :brand
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User"

  include JpPrefecture
  jp_prefecture :prefecture_code

end
