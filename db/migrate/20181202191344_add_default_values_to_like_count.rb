class AddDefaultValuesToLikeCount < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :like_count, :integer, :default => 0
  end
end
  
