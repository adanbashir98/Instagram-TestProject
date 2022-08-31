# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user_id: user.id) }

  context 'when valid factory' do
    it 'has a valid factory' do
      expect(post).to be_valid
    end
  end

  context 'when associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
  end

  context 'when validations' do
    it { is_expected.to validate_presence_of(:content) }
    # expect(described_class.image_presence).to include(:post)
  end

  # context 'when saving' do
  #   it 'would have a valid number of images' do
  #     expect(described_class.number_of_photos).to be <= 10
  #   end
  # end

  context 'when scopes' do
    it 'would have posts that are public' do
      expect(described_class.public_posts(user)).not_to include(:post)
    end
  end
end
