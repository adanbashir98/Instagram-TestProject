# frozen_string_literal: true

class StoryDeletionJob < ApplicationJob
  queue_as :default

  def perform_at(story_id)
    Story.find(story_id).destroy
    # Story.where(['created_at <= ?', 1.minute.ago]).each(&:destroy)
  end
end
