class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)
    @posts = @user.posts.where(is_public: true)
    p "++++++++++++++++",@posts
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
