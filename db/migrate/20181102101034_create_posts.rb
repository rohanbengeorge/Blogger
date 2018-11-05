class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :likes
      t.integer :comments
      t.boolean :is_public
      t.boolean :is_drafted
      t.text :tags

      t.timestamps
    end
  end
end
