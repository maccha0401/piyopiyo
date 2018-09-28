class AddDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:users, :user_type, false)
    change_column_default(:knowhows, :knowhow_class, false)
    change_column_default(:knowhows, :likes_count, 0)
  end
end
