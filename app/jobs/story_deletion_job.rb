# frozen_string_literal: true

# Deleting Story after 24 hours
class StoryDeletionJob < ApplicationJob
  # include Sidekiq:Worker
  # Sidekiq_options
  queue_as :default

  def perform(story_id)
    story = Story.find_by(id: story_id)
    Story.where(['created_at <= ?', 1.minute.ago]).each(&:destroy)
    # story = Story.find_by(id: story_id)
    # # Do something later
    # every(1.minute, 'delete.story') do
    #   byebug
    #   Story.where('created_at >= ?', 2.minutes.ago.utc).destroy
    # end
    # # story&.destroy
  end
end
