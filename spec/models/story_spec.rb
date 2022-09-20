# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Story, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:story) { FactoryBot.create(:story, user_id: user.id) }

  context 'when valid factory' do
    it 'has a valid factory' do
      expect(story).to be_valid
    end
  end

  context 'when invalid factory' do
    it 'has an invalid factory' do
      invalid_story = FactoryBot.build(:story, user_id: nil)
      expect(invalid_story).to be_invalid
    end
  end

  context 'when associations' do
    it { is_expected.to belong_to(:user) }
  end

  context 'when validations' do
    it { is_expected.to validate_presence_of(:image) }
  end

  context 'when callbacks' do
    it { is_expected.to callback(:story_deletion_job).after(:create) }
  end

  context 'when scopes' do
    let(:public_user) { FactoryBot.create(:user, status: 'Public') }
    let(:private_user) { FactoryBot.create(:user, status: 'Private') }
    let(:public_story) { FactoryBot.create(:story, user_id: public_user.id) }
    let(:private_story) { FactoryBot.create(:story, user_id: private_user.id) }

    it 'would have stories that are public' do
      expect(described_class.story_display(user)).to include(public_story)
    end

    it 'would not have stories that are not public' do
      expect(described_class.story_display(user)).not_to include(private_story)
    end
  end
end
