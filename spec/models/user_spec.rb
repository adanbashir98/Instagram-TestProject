# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:u) { FactoryBot.create(:user) }

  context 'when valid factory' do
    it 'has a valid factory' do
      expect(u).to be_valid
    end
  end

  context 'when associations' do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:stories).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }

    it {
      expect(u).to have_many(:followed_users).class_name('Follow').with_foreign_key(:follower_id).dependent(:destroy)
    }

    it {
      expect(u).to have_many(:following_users).class_name('Follow').with_foreign_key(:followee_id).dependent(:destroy)
    }
  end

  context 'when validations' do
    it { is_expected.to validate_presence_of(:full_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:avatar) }
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { is_expected.to validate_length_of(:full_name) }
    # it { is_expected.to have_content_type(:json) }
  end
end
