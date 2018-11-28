class ChangePostLikes < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :likes, :like_count
  end
end
