# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.public_posts(current_user).includes(:user, :likes, :comments)
    @stories = Story.story_display(current_user).includes(:user)
    current_user.followees.find_each do |user|
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
