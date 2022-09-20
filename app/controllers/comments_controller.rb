# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_comment, only: %i[destroy]

  def create
    @comment = current_user.comments.new(comment_params.merge(post_id: params[:post_id]))
    if @comment.save
      flash[:notice] = 'Comment created!'
    else
      flash[:alert] = 'Something went wrong. Try Again!'
    end

    redirect_to request.referer
  end

  def destroy
    authorize @comment
    @post = @comment.post
    if @comment.destroy
      flash[:notice] = 'Comment is deleted!'
    else
      flash[:alert] = 'Something went wrong. Try Again!'
    end

    redirect_to request.referer
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:comment_body)
  end
end
