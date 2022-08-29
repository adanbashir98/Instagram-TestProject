# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :comment_body, presence: true, length: { maximum: 30 }
end
