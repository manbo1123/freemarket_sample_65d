class AddColmunToItems < ActiveRecord::Migration[5.0]
  def change
    add_references :items, :brand, foreign_key: true
    add_references :items, :item_condition, null: false, foreign_key: true
    add_references :items, :postage_payer, null: false, foreign_key: true
    add_references :items, :size, null: false, foreign_key: true
    add_references :items, :preparation_day, null: false, foreign_key: true
    add_references :items, :postage_type, null: false, foreign_key: true
    add_references :items, :seller, null: false, foreign_key: true
    add_references :items, :buyer, foreign_key: true
  end
end
