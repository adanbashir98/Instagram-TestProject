# frozen_string_literal: true

# Stories Controller
class StoriesController < ApplicationController
  before_action :authenticate_user!
  def create
    @story = current_user.stories.create(story_params)
    redirect_to root_path
  end

  def show
    @story = Story.find(params[:id])
  end

  def destroy
    StoryDeletionJob.perform(Story.find(params[:id]))
    @story = current_user.stories.find(params[:id])
    if @story.destroy
      flash[:notice] = 'Story is deleted!'
    else
      flash[:alert] = 'Something went wrong. Try Again!'
    end
    redirect_to root_path
  end

  private

  def story_params
    params.require(:story).permit(:image)
  end
end
