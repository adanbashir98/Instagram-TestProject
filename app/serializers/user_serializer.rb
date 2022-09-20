# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :email, :full_name
  attribute :avatar do
    rails_blob_path(object.avatar, only_path: true)
  end
end
