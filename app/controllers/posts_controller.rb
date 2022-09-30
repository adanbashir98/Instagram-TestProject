# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :post, only: %i[show destroy edit update]
  before_action :authorize_post, only: %i[edit update destroy]

  def create
    post = current_user.posts.create(post_params)
    if post.invalid?
      flash[:alert] = 'Something went wrong. Try again!'
    else
      flash[:notice] = 'Post was successfully created.'
    end
    redirect_to root_path
  end

  def show; end

  def edit; end

  def update
    if post.update(post_params)
      flash[:notice] = 'Post edited!'
    else
      flash[:alert] = 'Something went wrong. Try Again!'
    end
    redirect_to post_path(post)
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
    @post ||= Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, images: [])
  end

  def authorize_post
    authorize post
  end
end
