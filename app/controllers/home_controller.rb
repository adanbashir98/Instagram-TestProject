# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc).includes(:likes, :comments, :user)
    @stories = Story.all.order(created_at: :desc).includes(:user)
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
