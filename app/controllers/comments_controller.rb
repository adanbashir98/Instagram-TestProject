# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_comment, only: %i[show destroy]

  def create
    @comment = current_user.comments.new(post_id: params[:post_id], comment_body: comment_params[:comment_body])
    if @comment.save
      flash[:notice] = 'Comment created!'
      @post = @comment.post
    else
      flash[:alert] = 'Something went wrong. Try Again!'
    end
    redirect_to request.referer
  end

  def show; end

  def destroy
    @post = @comment.post
    if @comment.destroy
      flash[:notice] = 'Comment is deleted!'
      redirect_to request.referer
    else
      flash[:alert] = 'Something went wrong. Try Again!'
    end
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:comment_body, :id)
  end
end
