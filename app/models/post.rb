# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  has_many_attached :images
  has_many :comments, dependent: :destroy
end
