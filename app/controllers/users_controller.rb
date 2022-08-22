# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: %i[show follow unfollow]

  def show
    @posts = @user.posts.order(created_at: :desc)
  end

  # def edit
  #   @user = User.find(params[:id])
  # end

  # def update
  #   current_user.update(user_params)
  #   redirect_to current_user
  # end

  def follow
    current_user.followees.concat(@user)
    redirect_to user_path(@user)
  end

  def unfollow
    current_user.followed_users.find_by(followee_id: @user.id).delete
    redirect_to user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:email, :encrypted_password, :username, :full_name, :bio, :avatar)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
