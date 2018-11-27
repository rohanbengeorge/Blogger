class Like < ApplicationRecord
  belongs_to :likable, polymorphic: true, optional: true
  validates :likes_id, presence: true
  validates :user_id, presence: true
end
