# frozen_string_literal: true

# Controller for home
class HomeController < ApplicationController
  def index
    @posts = Post.where("is_public = true")
  end

  def all_public_feeds
    @posts = Post.where('is_public = true')
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def all_feeds
    @posts = Post.all
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def personal_feeds
    followed_user = current_user.following_ids
    @posts = Post.where('user_id IN (:followed_users)', followed_users: followed_user)

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end
end
