# frozen_string_literal: true

FactoryBot.define do
  factory :follow do
    association :follower, :followee
  end
end
