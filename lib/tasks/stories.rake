# frozen_string_literal: true

namespace :stories do
  desc 'TODO'
  task story_deletion: :environment do
    Story.where(['created_at <= ?', 1.day.ago]).each(&:destroy)
  end
end
