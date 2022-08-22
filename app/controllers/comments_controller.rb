# frozen_string_literal: true

# Comments Controller
class CommentsController < ApplicationController
  before_action :authenticate_user!
  # before_action :find_comment, only: %i[show destroy]

  def create
    # @comment = @post.comments.create(comment_params)

    # if @comment.save

    # redirect_to root_path
    #   # (@post)
    # else
    #   redirect_to user_path(current_user)
    # end
    @comment = current_user.comments.new(post_id: params[:post_id], comment_body: comment_params[:comment_body])
    if @comment.save
      flash[:notice] = 'Comment created!'
      @post = @comment.post
    end
    # if current_user.id != @post.user.id
    #   redirect_to root_path
    # else
    redirect_to post_path(@post)
    # end
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

  # def find_comment
  #   @comment = current_user.comments.find(params[:id].to_i)

  #   return if @comment
  # end

  def comment_params
    params.require(:comment).permit(:comment_body, :id)
  end
end
