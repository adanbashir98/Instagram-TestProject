# frozen_string_literal: true

# Post Model
class Post < ApplicationRecord
  belongs_to :user
  has_many(:comments, -> { order(created_at: :desc) }, inverse_of: :post, dependent: :destroy)
  has_many(:likes, -> { order(created_at: :desc) }, inverse_of: :post, dependent: :destroy)
  # acts_as_votable
  # has_many_attached :image
  # has_many_attached :avatar
  # validate number_of_photos
  has_one_attached :image

  validate :image_presence
  # validate :number_of_photos

  def image_presence
    errors.add(:image, "can't be blank") unless image.attached?
  end

  # def number_of_photos
  #   errors.add(:images, 'Maximum 10 pictures can be added') if images.count > 10
  # end
end
