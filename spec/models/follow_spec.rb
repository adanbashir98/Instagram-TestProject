# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Follow, type: :model do
  let!(:follower) { FactoryBot.create(:user) }
  let!(:followee) { FactoryBot.create(:user) }
  let!(:follow) { FactoryBot.create(:follow, follower_id: follower.id, followee_id: followee.id) }

  context 'when valid factory' do
    it 'has a valid factory' do
      expect(follow).to be_valid
    end
  end

  context 'when invalid factory' do
    it 'has a invalid factory' do
      invalid_follow = FactoryBot.build(:follow, follower_id: -1, followee_id: -1)
      expect(invalid_follow).to be_invalid
    end
  end

  context 'when associations' do
    it { is_expected.to belong_to(:follower).class_name('User') }
    it { is_expected.to belong_to(:followee).class_name('User') }
  end

  context 'when validations' do
    it { is_expected.to validate_uniqueness_of(:follower_id).scoped_to(:followee_id) }
    it { is_expected.to validate_uniqueness_of(:followee_id).scoped_to(:follower_id) }
  end
end
