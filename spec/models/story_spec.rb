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

  context 'when associations' do
    it { is_expected.to belong_to(:user) }
  end

  context 'when validations' do
    it { is_expected.to validate_presence_of(:image) }
  end

  context 'when scopes' do
    it 'would have stories that are public' do
      expect(described_class.story_display(user)).not_to include(:story)
    end
  end

  # context 'when methods' do
  #   it 'would delete stories after 24 hours' do
  #     expect(described_class.StoryDeletionJob.perform_at(1.day, story.id)).to_not be_valid
  #   end
  # end
end
