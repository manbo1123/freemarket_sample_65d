class SendingDestination < ApplicationRecord
  belongs_to :user, optional: true

            kanji = /\A[一-龥ぁ-ん]/
            kana = /\A([ァ-ン]|ー)+\z/

  validates :destination_family_name, :destination_first_name, :destination_family_name_kana, :destination_first_name_kana, :post_code, :prefecture_id, :city, :house_number, presence: true
  validates :destination_family_name, :destination_first_name, format: { with: kanji }
  validates :destination_family_name_kana, :destination_first_name_kana, format: { with: kana }


  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end