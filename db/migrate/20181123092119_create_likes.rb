class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :likes_id
      t.integer :user_id
      t.string :likes_type
      t.timestamps
    end
    add_index :likes, :likes_id
    add_index :likes, :user_id
    add_index :likes, [:likes_id, :user_id], unique: true
  end
end
