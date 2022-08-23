# frozen_string_literal: true

namespace :user do
  desc 'deleting strories after 24 hours'
  task story_deletion: [:environment] do
    StoryDeletionJob.perform_now
  end
end
