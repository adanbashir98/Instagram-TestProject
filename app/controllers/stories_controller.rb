# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :story, only: %i[destroy show]

  def create
    story = current_user.stories.create(story_params)
    flash[:notice] = 'Story created!' if story.save
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
    if Story.pluck(:id).include?(params[:id].to_i)
      @story ||= Story.find(params[:id])
    else
      flash[:alert] = "This user's story does not exist."
      redirect_to root_path
    end
  end

  def story_params
    params.require(:story).permit(:image)
  end
end
