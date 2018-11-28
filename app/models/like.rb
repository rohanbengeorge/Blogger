class Like < ApplicationRecord
  belongs_to :likable, polymorphic: true, optional: true
  validates :likable_id, presence: true
  validates :user_id, presence: true
end
