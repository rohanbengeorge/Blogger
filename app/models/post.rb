# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :comments, dependent: :destroy

  has_many :likes, as: :likable
  acts_as_taggable
  # default_scope -> { order(created_at: :desc) }
  scope :by, ->(user) { where(user_id: user.id) }
  scope :only_public, -> { where(is_public: true) }
end
