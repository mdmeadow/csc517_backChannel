class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :parent_id
      t.string :body
      t.integer :user_id

      t.timestamps
    end
  end
end
