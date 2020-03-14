class ChangeColumnToNull < ActiveRecord::Migration[5.0]
  def change
    change_column_null :categories, :ancestry, true
  end
end
