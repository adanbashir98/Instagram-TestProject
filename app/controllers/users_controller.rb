# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :user, only: %i[show follow unfollow]

  def show
    @posts = user.posts.order(created_at: :desc)
  end

  def follow
    if current_user.followees.concat(user)
      flash[:notice] = 'User followed!'
      redirect_to user_path(user)
    else
      flash[:alert] = 'Something went wrong. Please try again later.'
    end
  end

  def unfollow
    if current_user.followed_users.find_by(followee_id: @user.id).delete
      flash[:notice] = 'User unfollowed!'
      redirect_to user_path(user)
    else
      flash[:alert] = 'Something went wrong. Please try again later.'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :encrypted_password, :username, :full_name, :bio, :avatar)
  end

  def user
    if User.pluck(:id).include?(params[:id].to_i)
      @user ||= User.find(params[:id])
    else
      flash[:alert] = 'This user does not exist.'
      redirect_to root_path
    end
  end
end
