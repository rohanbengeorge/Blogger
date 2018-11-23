class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :likes_id
      t.integer :liked_by_id

      t.timestamps
    end
    add_index :likes, :likes_id
    add_index :likes, :liked_by_id
    add_index :likes, [:likes_id, :liked_by_id], unique: true
  end
end
