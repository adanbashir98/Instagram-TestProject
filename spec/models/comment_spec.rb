# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user_id: user.id) }
  let(:comment) { FactoryBot.create(:comment, user_id: user.id, post_id: post.id) }

  context 'when valid factory' do
    it 'has a valid factory' do
      expect(comment).to be_valid
    end
  end

  context 'when invalid factory' do
    it 'has an invalid factory' do
      invalid_comment = FactoryBot.build(:comment, user_id: nil, post_id: nil)
      expect(invalid_comment).to be_invalid
    end
  end

  context 'when associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
  end

  context 'when validations' do
    it { is_expected.to validate_presence_of(:comment_body) }
    it { is_expected.to validate_length_of(:comment_body) }
  end
end
