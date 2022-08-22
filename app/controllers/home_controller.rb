# frozen_string_literal: true

# Home Controller
class HomeController < ApplicationController
  def index
    @users = User.all
    # byebug
    @posts = Post.all.order(created_at: :desc)
    @stories = Story.all.order(created_at: :desc)
    @suggestions = User.where.not(id: current_user.id)
    @likes = Like.all
    # byebug
  end
end
