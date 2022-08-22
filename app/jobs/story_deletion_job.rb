# frozen_string_literal: true

class StoryDeletionJob < ApplicationJob
  queue_as :default

  def perform
    Story.where(['created_at <= ?', 1.day.ago]).each(&:destroy)
  end
end
