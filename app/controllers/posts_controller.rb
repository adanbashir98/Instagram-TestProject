# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :post, only: %i[show destroy edit update]

  def create
    post = current_user.posts.create(post_params)
    flash[:alert] = 'Maximum images can only be 10. Try Again!' if post.invalid?
    redirect_to root_path
  end

  def show; end

  def edit; end

  def update
    if post.update(post_params)
      flash[:notice] = 'Post edited!'
      redirect_to post_path(post)
    else
      flash[:alert] = 'Something went wrong. Try Again!'
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    if post.destroy
      flash[:notice] = 'Post is deleted!'
    else
      flash[:alert] = 'Something went wrong. Try Again!'
    end
    redirect_to user_path(current_user)
  end

  private

  def post
    if Post.pluck(:id).include?(params[:id].to_i)
      @post ||= Post.find(params[:id])
    else
      flash[:alert] = 'This post does not exist.'
      redirect_to root_path
    end
  end

  def post_params
    params.require(:post).permit(:content, images: [])
  end
end
