# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  enum status: { Public: 0, Private: 1 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :stories, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :avatar

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow', inverse_of: :follower, dependent: :destroy
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow', inverse_of: :followee, dependent: :destroy
  has_many :followers, through: :following_users

  validates :email, uniqueness: true, presence: true
  validates :full_name, presence: true, length: { maximum: 30 }
  validates :avatar, presence: true,
                     blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..10.megabytes }
end
