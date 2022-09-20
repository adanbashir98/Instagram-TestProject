# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  context 'when valid factory' do
    it 'has a valid factory' do
      expect(user).to be_valid
    end
  end

  context 'when invalid factory' do
    it 'has an invalid factory' do
      invalid_user = FactoryBot.build(:user, full_name: nil)
      expect(invalid_user).to be_invalid
    end
  end

  context 'when associations' do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:stories).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }

    it {
      expect(user).to have_many(:followed_users).class_name('Follow').with_foreign_key(:follower_id).dependent(:destroy)
    }

    it {
      expect(user).to have_many(:following_users).class_name('Follow')
                                                 .with_foreign_key(:followee_id).dependent(:destroy)
    }
  end

  context 'when validations' do
    it { is_expected.to validate_presence_of(:full_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:avatar) }
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { is_expected.to validate_length_of(:full_name) }
  end
end
