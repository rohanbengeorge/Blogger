# frozen_string_literal: true

# Controller for home and feed
class HomeController < ApplicationController
  before_action :sort_checking, only: %i[all_public_feeds all_feeds personal_feeds]

  def index
    @posts = Post.where(is_public: true)
  end

  def all_public_feeds
    @posts = @posts.where(is_public: true)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def all_feeds
    p "+++++++++++++++++++",@posts
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def personal_feeds
    followed_users = current_user.following_ids
    @posts = @posts.where(user_id: followed_users)

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

  private

  def sort_checking
    if params[:sort_type] == 'Date'
      @posts = Post.order(created_at: :desc)
    elsif params[:sort_type] == 'Likes'
      @posts = Post.order(like_count: :desc)
    else
      @posts = Post.all
    end
  end

end
