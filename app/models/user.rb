# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  enum status: { accessible: 0, inaccessible: 1 }
  validates :email, uniqueness: true
  validates :username, uniqueness: true, length: { minimum: 5 }, presence: true
  # :username, uniqueness: true
  # validates_presence_of :full_name, :username
  # , :username
end
