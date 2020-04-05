class ChangeColumnToNotNull < ActiveRecord::Migration[5.0]
  def change
    change_column_null :items, :trading_status, true
  end
end
