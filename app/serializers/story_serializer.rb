# frozen_string_literal: true

class StorySerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :user_id
  attribute :image do
    rails_blob_path(object.image, only_path: true)
  end
end
