# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  enum status: { publc: 0, prvate: 1 }
  validates :email, uniqueness: true
  # validates :username, uniqueness: true, presence: true, length: { maximum: 20 }
  validates :full_name, presence: true, length: { maximum: 30 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :stories, dependent: :destroy
  has_many :likes, dependent: :destroy
  # acts_as_voter
  has_one_attached :avatar

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users
  # has_many :follower_relationships, foreign_key:
  #                                     :following_id,
  #                                     class_name: 'Follow'
  # has_many :followers, through: :follower_relationships, source: :follower

  # has_many :following_relationships, foreign_key:
  #                                     :follower_id, class_name: 'Follow'
  # has_many :following, through: :following_relationships, source: :following

  # def follow(user_id)
  #   following_relationships.create(following_id: user_id)
  # end

  # def unfollow(user_id)
  #   following_relationships.find_by(following_id: user_id).destroy
  # end

  # def is_following?(user_id)
  #   relationship = Follow.find_by(follower_id: id, following_id: user_id)
  #   return true if relationship
  # end
  # def self.search(keyword)
  #   if keyword
  #     where('name LIKE ?', "%#{keyword}%")
  #   end
  # end
  # scope :search, ->(keyword) { where('name LIKE ?', "%#{keyword}%") }
end
