# frozen_string_literal: true

# Controller for Like
class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(likable_id: params[:likable_id])
    @like.likable_type = params[:likable_type]
    @initial = params[:likable_type] == 'Post' ? 'p' : 'c'
    @post_id = params[:likable_id]
    if @initial == 'p'
      @post = Post.find_by(id: params[:likable_id])
      @post.like_count = @post.likes.count + 1
      @post.save
    end
    if @like.save!
      flash[:notice] = 'Success'
    else
      flash[:alert] = 'Unsuccessful'
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @like = Like.find_by(
      likable_id: params[:likable_id],
      user_id: params[:user_id],
      likable_type: params[:likable_type]
    )
    @initial = params[:likable_type] == 'Post' ? 'p' : 'c'
    @post_id = params[:likable_id]
    if @initial == 'p'
      @post = Post.find_by(id: params[:likable_id])
      @post.like_count = @post.likes.count - 1
      @post.save
    end
    @like&.destroy
  end
end
