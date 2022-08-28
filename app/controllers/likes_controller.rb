# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @post = Post.find(params[:id])
    if @post.present?
      @like = @post.likes.create(user_id: current_user.id)
      if @like.save
        flash[:notice] = 'Post liked!'
        redirect_to request.referer
      else
        flash[:alert] = 'Something went wrong. Try Again!'
      end
    else
      flash[:alert] = 'Post was not found.'
    end
  end

  def destroy
    @like = Like.find(params[:id])
    if @like.destroy
      flash[:notice] = 'Post unliked!'
      redirect_to request.referer
    else
      flash[:alert] = 'Something went wrong. Try Again!'
    end
  end
end
