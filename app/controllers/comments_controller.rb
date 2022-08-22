# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.new(post_id: params[:post_id], comment_body: comment_params[:comment_body])
    if @comment.save
      flash[:notice] = 'Comment created!'
      @post = @comment.post
    end
    redirect_to post_path(@post)
  end

  def show
    @comment = current_user.comments.find(params[:id])
  end

  def destroy
    @post = Comment.find_by(id: params[:id]).post
    @comment = @post.comments.find(params[:id])
    if @comment.destroy
      flash[:notice] = 'Comment is deleted!'
      redirect_to post_path(@post)
    else
      flash[:alert] = 'Something went wrong. Try Again!'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_body, :id)
  end
end
