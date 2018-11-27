class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :parent,  class_name: 'Comment', optional: true
  has_many   :replies, class_name: 'Comment', foreign_key: 'parent_id'
  has_many :likes, as: :likable
  default_scope -> { order(created_at: :asc) }
  self.per_page = 5
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
