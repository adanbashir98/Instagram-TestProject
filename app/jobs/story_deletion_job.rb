# frozen_string_literal: true

class StoryDeletionJob < ApplicationJob
  queue_as :default

  def perform_later(story_id)
    # sleep(1.minute)
    Story.find(story_id).destroy
    # Story.where(['created_at <= ?', 1.minute.ago]).each(&:destroy)
  end
end
