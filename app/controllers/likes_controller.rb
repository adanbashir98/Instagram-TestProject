# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:id])
    @like = @post.likes.create(user_id: current_user.id)
    flash[:notice] = 'Post liked!' if @like.save
    redirect_to post_path(@post)
  end

  def destroy
    @like = Like.find_by(id: params[:id])
    @post = @like.post
    if @like.destroy
      flash[:notice] = 'Post unliked!'
      redirect_to post_path(@post)
    else
      flash[:alert] = 'Something went wrong. Try Again!'
    end
  end
end
