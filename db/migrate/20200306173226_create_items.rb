class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string      :name,              null: false
      t.text        :introduction,      null: false
      t.integer     :price,             null: false
      t.integer     :prefecture_code,   null: false
      t.integer     :trading_status,    null: false
      t.timestamps  :deal_closed_date

      t.timestamps
    end
  end
end
