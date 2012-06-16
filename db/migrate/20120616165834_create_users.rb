class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :userName
      t.string :password
      t.boolean :isAdmin

      t.timestamps
    end
  end
end
