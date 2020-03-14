class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         kanji = /\A[一-龥ぁ-ん]/
         kana = /\A([ァ-ン]|ー)+\z/
         
  validates :nickname, :family_name, :first_name, :family_name_kana, :first_name_kana, :birthday, presence: true
  validates :family_name, format: { with: kanji }
  validates :first_name, format: { with: kanji }
  validates :family_name_kana, format: { with: kana }
  validates :first_name_kana, format: { with: kana }

  has_one :sending_destination
  # has_one :credit_card

end
