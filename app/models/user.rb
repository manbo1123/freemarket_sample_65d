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
  has_many :cards
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :todo_lists
  has_many :user_evaluations
  has_many :seller_items, foreign_key: "seller_id", class_name: "items"
  has_many :buyer_items, foreign_key: "buyer_id", class_name: "items"
  has_one :profile, dependent: :destroy
  has_one :sns_authentication, dependent: :destroy
  has_one :sending_destination, dependent: :destroy
  has_one :credit_card, dependent: :destroy
end
