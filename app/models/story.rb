# frozen_string_literal: true

class Story < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  validates :image, presence: true

  scope :story_display, ->(c_user) { Story.joins(:user).where('users.status =? OR users.id =?', 0, c_user.id) }

  after_create :story_deletion_job

  def story_deletion_job
    StoryDeletionJob.perform_at(1.day, id)
  end
end
