# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_relationships,
           class_name: 'Relationship',
           foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships,
           class_name: 'Relationship', foreign_key: 'followed_id',
           dependent: :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :likes, dependent: :destroy
  self.per_page = 10
  has_one_attached :avatar
  def account_active?
    return false if ban_till_date > Date.today

    true
  end

  def active_for_authentication?
    super && account_active?
  end

  def inactive_message
    account_active? ? super : 'Your Account is banned till ' + ban_till_date.to_s + ' for breaking our policies'
  end

  # Follows a user.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  def follows?(other)
    following?(other)
  end
end
