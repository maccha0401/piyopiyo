class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :login_id
      t.string :user_name
      t.string :password_digest
      t.boolean :user_type

      t.timestamps
    end
  end
end
