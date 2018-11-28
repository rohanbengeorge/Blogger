# frozen_string_literal: true

# Controller for user CRUD operation, to assign and remove adminand to ban user
class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[index show edit update
                                              destroy following followers]
  before_action :set_user, only: %i[edit update destroy ban_user
                                    assign_admin_status followers
                                    remove_admin_status following ]
  before_action :check_user_is_admin, only: %i[ban_user assign_admin_status
                                               remove_admin_status]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find params[:id]
    @posts = Post.by @user
    @posts = @posts.only_public unless current_user.follows? @user
  end

  def new
    @user = User.new
  end

  def edit; end

  def create; end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html {
          redirect_back(fallback_location: root_path,
                        notice: 'User was successfully updated.')
        }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html {
        redirect_back(fallback_location: root_path,
                      notice: 'User was successfully destroyed.')
      }
      format.json { head :no_content }
    end
  end

  def assign_admin_status
    @user.update_attribute :admin, true
    redirect_back(fallback_location: root_path,
                  notice: 'ADMIN status was assigned succesfully.')
  end

  def remove_admin_status
    @user.update_attribute :admin, false
    redirect_back(fallback_location: root_path,
                  notice: 'ADMIN status was removed succesfully.')
  end

  def ban_user
    @user.ban_till_date = Date.today + params[:ban_days].to_i.days
    @user.save
    render json: { status: 'ok' }
  end

  def following
    @title = 'Following'
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    redirect_to(root_url) unless current_user == @user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                                 :password_confirmation, :avatar)
  end
end
