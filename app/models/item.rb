class Item < ApplicationRecord
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :favorites
  has_many :itemimgs, dependent: :destroy
  has_one :user_evaluation
  belongs_to :size
  belongs_to :item_condition
  belongs_to :postage_payer
  belongs_to :preparation_day
  belongs_to :postage_type
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User"

  include JpPrefecture
  jp_prefecture :prefecture_code

end
