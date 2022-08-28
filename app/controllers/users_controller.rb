# frozen_string_literal: true

class UsersController < ApplicationController
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
    if current_user.followees.find(@user.id).present?
      current_user.followed_users.where(followee_id: @user.id).destroy_all
      flash[:notice] = 'User unfollowed!'
    else
      flash[:alert] = 'Something went wrong. Please try again later.'
    end
    redirect_to user_path(user)
  end

  private

  def user
    @user ||= User.find(params[:id])
  end
end
