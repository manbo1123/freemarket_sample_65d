class AddItemimg < ActiveRecord::Migration[5.0]
  def change
    add_reference :items, :itemimg ,foreign_key: true, :null => false
  end
end
