# frozen_string_literal: true

# Controller for Comments
class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

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
    # @user = User.find params[:user_id]
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
        flash[:notice] = 'Comment was successfully created.'
        @post = Post.find(params['post_id'])
        @all_comments = @post.comments.paginate(page: params[:page])
        format.html
        format.json { render :show, status: :created, location: @comment }
        format.js
      else
        flash[:notice] = 'Comment was not created.'
        format.html
        format.json {
          render json: @comment.errors, status: :unprocessable_entity
        }
        format.jsparams['post_id']
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_back(fallback_location: root_path, notice: 'Comment was successfully updated.') }
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
                    notice: 'You need to be a admin to edit others comments')
    end
    @comment.destroy
    respond_to do |format|
      format.html {
        redirect_back(fallback_location: root_path,
                      notice: 'Comment was successfully destroyed.')
      }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_id)
        # .merge!(post_id: params['post_id'])
  end
end
