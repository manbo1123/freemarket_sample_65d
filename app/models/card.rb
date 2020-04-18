class Card < ApplicationRecord
  belongs_to :user

  validates :customer_id, :card_id, :user_id, presence: true
end
