# frozen_string_literal: true

# Controller for user CRUD operation, to assign and remove adminand to ban user
class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[index show edit update destroy]
  before_action :set_user, only: %i[show edit update destroy ban_user assign_admin_status remove_admin_status]
  before_action :check_user_is_admin, only: %i[index ban_user assign_admin_status remove_admin_status]

  def index
    @users = User.all
  end

  def show
    @post = Post.new
  end

  def new
    @user = User.new
  end

  def edit; end

  def create; end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
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
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def assign_admin_status
    @user.update_attribute :admin, true
    redirect_to users_path, notice: 'ADMIN status was assigned succesfully.'
  end

  def remove_admin_status
    @user.update_attribute :admin, false
    redirect_to users_path, notice: 'ADMIN status was removed succesfully.'
  end

  def ban_user
    @user.ban_till_date = Date.today + params[:ban_days].to_i.days
    @user.save
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
