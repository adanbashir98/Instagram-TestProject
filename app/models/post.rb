# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many(:comments, -> { order(created_at: :desc) }, inverse_of: :post, dependent: :destroy)
  has_many(:likes, -> { order(created_at: :desc) }, inverse_of: :post, dependent: :destroy)
  has_many_attached :images

  validate :image_presence
  validate :number_of_photos
  validate :content_presence

  def content_presence
    errors.add(:content, "Can't be blank!") if content.blank?
  end

  def image_presence
    errors.add(:images, "Can't be blank!") unless images.attached?
  end

  def number_of_photos
    errors.add(:images, 'Maximum 10 pictures can be added') if images.size > 10
  end
end
