# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user_id: user.id) }
  let(:like) { FactoryBot.create(:like, user_id: user.id, post_id: post.id) }

  context 'when valid factory' do
    it 'has a valid factory' do
      expect(like).to be_valid
    end
  end

  context 'when associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
  end

  # context 'when validations' do
  #   # it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:post_id) }
  #   it { is_expected.to validate(%i[user_id], uniqueness: { scope: [:post_id] }) }
  # end
end
