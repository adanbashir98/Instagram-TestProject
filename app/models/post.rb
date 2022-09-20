# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many(:comments, -> { order(created_at: :desc) }, inverse_of: :post, dependent: :destroy)
  has_many(:likes, -> { order(created_at: :desc) }, inverse_of: :post, dependent: :destroy)
  has_many_attached :images

  validates :images, presence: true,
                     blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..10.megabytes }
  # validate :image_presence
  # validate :number_of_photos
  validates :content, presence: true, length: { maximum: 30 }

  # def image_presence
  #   errors.add(:images, "Can't be blank!") unless images.attached?
  # end

  # def number_of_photos
  #   errors.add(:images, 'are more than 10. Maximum number of images can be 10!') if images.size > 10
  # end

  scope :public_posts, ->(c_user) { Post.joins(:user).where('users.status =? AND users.id !=?', 0, c_user.id) }
end
