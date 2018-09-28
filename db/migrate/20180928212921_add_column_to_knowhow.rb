class AddColumnToKnowhow < ActiveRecord::Migration[5.1]
  def change
    add_column :knowhows, :views_count, :integer, default: 0
  end
end
