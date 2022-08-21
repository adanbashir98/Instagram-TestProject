# frozen_string_literal: true

namespace :sample do
  desc 'saying hi to cron'
  task test: [:environment] do
    s = Story.where(['created_at <= ?', 1.day.ago]).each(&:destroy)
  end
end
