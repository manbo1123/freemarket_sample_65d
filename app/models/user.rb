class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         kanji = /\A[一-龥ぁ-ん]/
         kana = /\A([ァ-ン]|ー)+\z/
         
  validates :nickname, presence: true
  validates :family_name, presence: true, format: { with: kanji }
  validates :first_name, presence: true, format: { with: kanji }
  validates :family_name_kana, presence: true, format: { with: kana }
  validates :first_name_kana, presence: true, format: { with: kana }
  validates :birthday, presence: true

  has_one :sending_destination
  # has_one :credit_card

end
