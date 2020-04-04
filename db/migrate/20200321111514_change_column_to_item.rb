class ChangeColumnToItem < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :trading_status, :integer, default: 0
  end
end
