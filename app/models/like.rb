class Like < ApplicationRecord
  belongs_to :likes, class_name: "User"
  belongs_to :liked_by, class_name: "Post"
  validates :likes_id, presence: true
  validates :liked_by_id, presence: true
end
