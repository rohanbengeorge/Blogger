# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
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
end
