# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :story, only: %i[destroy show]

  def create
    story = current_user.stories.create(story_params)
    if story.save
      flash[:notice] = 'Story created!'
    else
      flash[:alert] = 'Something went wrong. Please try again!'
    end
    redirect_to root_path
  end

  def show; end

  def destroy
    story = current_user.stories.find(params[:id])
    if story.destroy
      flash[:notice] = 'Story is deleted!'
    else
      flash[:alert] = 'Something went wrong. Try Again!'
    end
    redirect_to root_path
  end

  private

  def story
    @story ||= Story.find(params[:id])
  end

  def story_params
    params.require(:story).permit(:image)
  end
end
