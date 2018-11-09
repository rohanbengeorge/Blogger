class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :parent,  class_name: "Comment", optional: true   #-> requires "parent_id" column
  has_many   :replies, class_name: "Comment", foreign_key: "parent_id"
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
