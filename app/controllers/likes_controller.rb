# frozen_string_literal: true

# Likes Controller
class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    # byebug
    @post = Post.find(params[:id])
    # @user = @post.user
    @like = Like.create(user_id: current_user.id, post_id: @post.id)
    # @like = Like.create(like_params)
    redirect_to post_path(@post)
  end

  def destroy
    # @user = User.find(params[:user_id])
    # @like = Like.find(params[:id])
    # # @like.del
    # # byebug
    # @post = @like.post

    # @like.destroy
    # byebug
    @post = Like.find_by(id: params[:id]).post
    @like = @post.likes.find(params[:id])
    @like.destroy
    # if ()
    redirect_to post_path(@post)
  end

  private

  def like_params
    require(:like).permit(:id)
  end
end
