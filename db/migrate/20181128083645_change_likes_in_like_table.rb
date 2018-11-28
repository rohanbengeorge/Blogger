class ChangeLikesInLikeTable < ActiveRecord::Migration[5.2]
  def change
    rename_column :likes, :likes_id, :likable_id
    rename_column :likes, :likes_type, :likable_type
  end
end
