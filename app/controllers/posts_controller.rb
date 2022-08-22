# frozen_string_literal: true

# Posts Controller
class PostsController < ApplicationController
  # respond_to :js, :html, :json
  before_action :authenticate_user!
  before_action :find_post, only: %i[show destroy edit update]

  def create
    # @user = User.find(params[:id])
    # @post = @user.posts.create(post_params)
    # redirect_to root_path
  # end
    @post = current_user.posts.create(post_params)
    redirect_to root_path
  end

  def show
    @posts = Post.all
  end

  def edit
    # edit
  end

  def update
    # if
      @post.update(post_params)
      # render 'edit'
      redirect_to post_path(@post)
    # else
      # redirect_to root_path
      # render 'edit'
    # end
  end

  # def like
  #   if params[:format] == 'like'
  #     @post.liked_by current_user
  #   elsif params[:format] == 'unlike'
  #     @post.unliked_by current_user
  #   end
  # end

  def destroy
    @post = current_user.posts.find(params[:id])
    if @post.destroy
      flash[:notice] = 'Post is deleted!'
    else
      flash[:alert] = 'Something went wrong. Try Again!'
    end
    redirect_to user_path(current_user)
  end

  private

  def find_post
    @post = Post.find(params[:id])
    return if @post

    flash[:danger] = 'Post does not exist. Try another post.'
    redirect_to user_path
  end

  def post_params
    params.require(:post).permit(:content, :image)
  end
end
