class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :item_imgs, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
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

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :prefecture_code, presence: true
  validates :trading_status, presence: true
  validates :category_id, presence: true
  validates :item_condition_id, presence: true
  validates :postage_payer_id, presence: true

  validates :preparation_day_id, presence: true
  validates :postage_type_id, presence: true
  validates :seller_id, presence: true

  def previous
    Item.order('created_at desc, id desc').where('created_at <= ? and id < ?', created_at, id).first
  end

  def next
    Item.order('created_at desc, id desc').where('created_at >= ? and id > ?', created_at, id).reverse.first
  end
end
