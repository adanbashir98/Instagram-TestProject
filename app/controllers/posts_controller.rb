# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :post, only: %i[show destroy edit update]

  def create
    post = current_user.posts.create(post_params)
    if post.invalid?
      flash[:alert] = post.errors.full_messages.to_sentence
    else
      flash[:notice] = 'Post was successfully created.'
    end
    redirect_to root_path
  end

  def show; end

  def edit
    authorize post
  end

  def update
    authorize post
    if post.update(post_params)
      flash[:notice] = 'Post edited!'
    else
      flash[:alert] = 'Something went wrong. Try Again!'
    end
    redirect_to post_path(post)
  end

  def destroy
    authorize post
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
end
