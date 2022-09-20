# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    association :user
    content { Faker::Lorem.paragraph_by_chars(number: 20) }
    images { Rack::Test::UploadedFile.new(Rails.root.join('spec/images/test.png'), 'image/png') }
  end
end
