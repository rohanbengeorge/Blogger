# frozen_string_literal: true

# Controller for post CRUD operation
class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :set_locale 
  before_action :authorized_user, only: %i[index show destroy]
  before_action :correct_user, only: %i[edit update ]

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.all
  end

  def show; end

  def new
    @post = current_user.posts.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit; end

  def create
    @post = current_user.posts.new(post_params)
    @post.content = params[:content]
    respond_to do |format|
      if @post.save
        format.html {
          redirect_back(fallback_location: root_path,
                        notice: t('post.create_message'))
        }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html {
          redirect_back(fallback_location: root_path,
                        notice: t('post.update_message'))
        }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @post.destroy 
      notice_msg = t('post.del_success_msg')
    else
      notice_msg = t('post.del_unsuccessful_msg')
    end
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path, notice: notice_msg) }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
  
  def authorized_user
    @user = User.find(params[:user_id])
    return if current_user.admin? || current_user == @user
    redirect_to root_path
  end

  def correct_user
    @user = User.find(params[:user_id])
    redirect_to(root_url) unless current_user == @user
  end

  def set_locale  
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def post_params
    params.require(:post).permit(:title, :content, :likes, :comments,
                                 :is_public, :is_drafted, :tags, :tag_list,
                                 :user_id, images: [])
  end
end
