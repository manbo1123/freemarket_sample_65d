class SendingDestination < ApplicationRecord
  belongs_to :user, optional: true

  phone_number = /\A\d{10,11}\z/
  validates :destination_family_name, :destination_first_name, :destination_family_name_kana, :destination_first_name_kana, :post_code, :prefecture_id, :city, :house_number, presence: true
  # validates :phone_number, format: { with: phone_number }


  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end