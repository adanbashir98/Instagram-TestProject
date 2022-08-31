# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    association :user, :post
    comment_body { Faker::Lorem.paragraph_by_chars(number: 20) }
  end
end
