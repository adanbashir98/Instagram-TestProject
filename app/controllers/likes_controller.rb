# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:id])
    @like = Like.create(user_id: current_user.id, post_id: @post.id)
    redirect_to post_path(@post)
  end

  def destroy
    @post = Like.find_by(id: params[:id]).post
    @like = @post.likes.find(params[:id])
    @like.destroy
    redirect_to post_path(@post)
  end

  private

  def like_params
    require(:like).permit(:id)
  end
end
