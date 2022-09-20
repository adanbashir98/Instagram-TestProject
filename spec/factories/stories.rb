# frozen_string_literal: true

FactoryBot.define do
  factory :story do
    association :user
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/images/test.png'), 'image/png') }

    factory :story_skips_validate do
      to_create { |instance| instance.save(validate: false) }
    end
  end
end
