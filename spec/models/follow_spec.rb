# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Follow, type: :model do
  let(:u1) { FactoryBot.create(:user) }
  let(:u2) { FactoryBot.create(:user) }
  let(:follow) {  FactoryBot.create(:follow, follower_id: u1.id, followee_id: u2.id) }

  context 'when valid factory' do
    it 'has a valid factory' do
      expect(follow).to be_valid
    end
  end

  context 'when associations' do
    it { is_expected.to belong_to(:follower).class_name('User') }
    it { is_expected.to belong_to(:followee).class_name('User') }
  end

  # context 'when validations' do
  #   # it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:post_id) }
  #   it { is_expected.to validate(%i[user_id], uniqueness: { scope: [:post_id] }) }
  # end
end
