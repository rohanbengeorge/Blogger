# frozen_string_literal: true

# Controller for Comments
class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_locale 
  before_action :authorized_user, only: %i[index show destroy]
  before_action :correct_user, only: %i[edit update ]

  # GET /comments
  # GET /comments.json
  def index
    @post = Post.find params[:post_id]
    @comments = @post.comments.all
  end

  # GET /comments/1
  # GET /comments/:id.json
  def show; end

  # GET /comments/new
  def new
    @comment = current_user.comments.new
    @comment.post_id = params[:post_id]
    @comment.parent_id = params[:parent_id]

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    if @comment.user_id != current_user.id && !current_user.admin?
      redirect_back(fallback_location: root_path,
                    notice: 'You need to be a admin to edit others comments')
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params['post_id']
    # @comment.parent_id = params[:parent_id]

    respond_to do |format|
      if @comment.save
        flash[:notice] = t('comment.create_success_mesg')
        @post = Post.find(params['post_id'])
        @all_comments = @post.comments.paginate(page: params[:page])
        format.html
        format.json { render :show, status: :created, location: @comment }
        format.js
      else
        flash[:notice] = t('comment.create_unsuccessful_msg')
        format.html
        format.json {
          render json: @comment.errors, status: :unprocessable_entity
        }
        format.js 
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_back(fallback_location: root_path, notice: t('comment.update_msg')) }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json {
          render json: @comment.errors, status: :unprocessable_entity
        }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    if @comment.user_id != current_user.id && !current_user.admin?
      redirect_back(fallback_location: root_path,
                    notice: t('comment.del_not_admin_msg'))
    end
    if @comment.destroy
      notice_msg = t('comment.del_success_msg')
    else
      notice_msg = t('comment.del_unsuccessful_msg')
    end
    respond_to do |format|
      format.html {
        redirect_back(fallback_location: root_path,
                      notice: notice_msg)
      }
      format.json { head :no_content }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
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

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_id)
                                    .merge(post_id: params['post_id'])
  end
end
