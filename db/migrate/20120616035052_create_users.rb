class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :user_id
      t.string :userName
      t.string :password
      t.boolean :isAdmin

      t.timestamps
    end
  end
end
