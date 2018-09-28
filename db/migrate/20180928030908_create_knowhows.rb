class CreateKnowhows < ActiveRecord::Migration[5.1]
  def change
    create_table :knowhows do |t|
      t.boolean :knowhow_class
      t.integer :category_id
      t.integer :language_id
      t.string :title
      t.string :key_message
      t.text :content
      t.string :attachment
      t.integer :create_user_id
      t.integer :update_user_id
      t.integer :likes_count

      t.timestamps
    end
  end
end
