# frozen_string_literal: true

class Story < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  after_create :story_deletion_job

  def story_deletion_job
    StoryDeletionJob.perform_at(1.minute.from_now)
  end

  # def delete_story
  #   Story.where(['created_at <= ?', 1.minute.ago]).find_each(&:destroy)
  # after_create :Story_Deletion_Job
  # , content_type: 'image/jpeg'
  # end
end
