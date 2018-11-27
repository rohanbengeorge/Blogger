class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(likes_id: params[:likes_id] )
    @like.likes_type = params[:likes_type]
    @initial = params[:likes_type] == 'Post'? 'p' : 'c'
    @post_id = params[:likes_id]
    p params
    respond_to do |format|
      if @like.save!
        flash[:notice] = 'Success.'
        format.js
      else
        flash[:notice] = 'Unsuccessful'
        format.js
      end
    end
  end

  def destroy
    @like = Like.find_by(
      likes_id: params[:likes_id],
      user_id: params[:user_id],
      likes_type: params[:likes_type]
    )
    @initial = params[:likes_type] == 'Post'? 'p' : 'c'
    @post_id = params[:likes_id]
    @like.destroy unless @like.nil?
  end
end

