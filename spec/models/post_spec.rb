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

  context 'when invalid factory' do
    it 'has an invalid factory' do
      invalid_post = FactoryBot.build(:post, user_id: nil)
      expect(invalid_post).to be_invalid
    end
  end

  context 'when associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
  end

  context 'when validations' do
    it { is_expected.to validate_presence_of(:content) }
  end

  context 'when custom validations' do
    it 'validates number of images in a post' do
      post.number_of_photos
      expect(post.errors.messages).to match(post.errors.messages)
    end

    it 'validates presence of images in a post' do
      post.image_presence
      expect(post.errors.messages).to match(post.errors.messages)
    end
  end

  context 'when scopes' do
    let(:public_user) { FactoryBot.create(:user, status: 'Public') }
    let(:private_user) { FactoryBot.create(:user, status: 'Private') }
    let(:public_post) { FactoryBot.create(:post, user_id: public_user.id) }
    let(:private_post) { FactoryBot.create(:post, user_id: private_user.id) }

    it 'would have posts that are public' do
      expect(described_class.public_posts(user)).to include(public_post)
    end

    it 'would not have posts that are not public' do
      expect(described_class.public_posts(user)).not_to include(private_post)
    end
  end
end
