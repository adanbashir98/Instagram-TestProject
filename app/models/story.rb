# frozen_string_literal: true

# Story Model
class Story < ApplicationRecord
  belongs_to :user

  has_one_attached :image
end
