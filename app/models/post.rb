# frozen_string_literal: true

# Post Model
class Post < ApplicationRecord
  belongs_to :user
  has_many(:comments, -> { order(created_at: :desc) }, inverse_of: :post, dependent: :destroy)
  has_many(:likes, -> { order(created_at: :desc) }, inverse_of: :post, dependent: :destroy)
  has_many_attached :images
  # has_one_attached :image

  # validate :image_presence
  # validate :number_of_photos

  # def image_presence
  #   errors.add(:images, "can't be blank") unless image.attached?
  # end

#   def number_of_photos
#     errors.add(:image, 'Maximum 10 pictures can be added') if image.count > 10
#   end
end
