# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  enum status: { accessible: 0, inaccessible: 1 }
  validates :email, uniqueness: true
  validates :full_name, presence: true, length: { maximum: 30 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :stories, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :avatar

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users

  # def self.search(keyword)
  #   if keyword
  #     where('username LIKE ?', "%#{keyword}")
  #   else
  #     nil
  #   end
  # end
  # scope :search, ->(keyword) { where('full_name LIKE ?', "%#{keyword}%") }
end
