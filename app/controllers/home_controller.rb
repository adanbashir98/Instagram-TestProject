# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.joins(:user).where('users.status =? AND users.id !=?', 0, current_user.id)
    @stories = Story.joins(:user).where('users.status =? OR users.id =?', 0, current_user.id)
    @all_users = User.all
    @all_users.each do |user|
      next unless user.followers.pluck(:follower_id).include?(current_user.id)

      @private_posts = Post.where(user_id: user.id)
      @posts += @private_posts
      @private_stories = Story.where(user_id: user.id)
      @stories += @private_stories
    end
    @suggestions = User.where.not(id: current_user.id)
    @search = User.ransack(params[:q])
    @users = if params.key?(:q)
               @search.result
             else
               User.all
             end
  end

  def search
    @search = User.ransack(params[:q])
    @users = @search.result

    respond_to do |format|
      format.js
    end
  end
end
