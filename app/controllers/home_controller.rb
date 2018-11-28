# frozen_string_literal: true

# Controller for home and feed
class HomeController < ApplicationController
  def index
    @posts = Post.where(is_public: true)
  end

  def all_public_feeds
    if params[:sort_type] == 'Date'
      @posts = Post.order(created_at: :desc).where(is_public: true)
    elsif params[:sort_type] == 'Likes'
      p "+++++++++++++++",Post.first.likes.count
      @posts = Post.order('posts.likes.count').where(is_public: true)
    else
      @posts = Post.where(is_public: true)
    end
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
    followed_users = current_user.following_ids
    @posts = Post.where(user_id: followed_users)

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def tagged_feeds
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
      followed_users = current_user.following_ids
      @posts = @posts.where(user_id: followed_users).or(@posts.where(is_public: true))
    else
      @posts = Post.where(is_public: true)
    end
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end
end
