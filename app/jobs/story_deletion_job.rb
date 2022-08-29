# frozen_string_literal: true

class StoryDeletionJob < ApplicationJob
  queue_as :default

  def perform_later(story_id)
    Story.find(story_id).destroy
  end
end
