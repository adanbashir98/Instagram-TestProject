# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.unique.password }
    bio { Faker::Lorem.paragraph_by_chars(number: 20) }
    avatar { Rack::Test::UploadedFile.new(Rails.root.join('spec/images/test.png'), 'image/png') }
    status { [0, 1].sample }
  end
end
