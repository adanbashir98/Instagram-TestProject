# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: %i[show destroy edit update]

  def create
    @post = current_user.posts.create(post_params)
    redirect_to root_path if @post.valid?
  end

  def show
    @posts = Post.all
  end

  def edit; end

  def update
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    if @post.destroy
      flash[:notice] = 'Post is deleted!'
    else
      flash[:alert] = 'Something went wrong. Try Again!'
    end
    redirect_to user_path(current_user)
  end

  private

  def find_post
    @post = Post.find(params[:id])
    return if @post

    flash[:danger] = 'Post does not exist. Try another post.'
    redirect_to user_path
  end

  def post_params
    params.require(:post).permit(:content, images: [])
  end
end
