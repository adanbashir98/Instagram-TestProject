# frozen_string_literal: true

require 'rails_helper'

describe PostPolicy do
  subject { described_class.new(user, post) }

  let(:post) { FactoryBot.create(:post) }

  context 'when user is a guest' do
    let(:user) { nil }

    it { is_expected.not_to permit_action(:create) }
    it { is_expected.not_to permit_action(:destroy) }
    it { is_expected.not_to permit_action(:update) }
    it { is_expected.not_to permit_action(:edit) }
  end

  context 'when a non-admin user' do
    let(:user) { FactoryBot.create(:user) }

    it { is_expected.not_to permit_action(:create) }
    it { is_expected.not_to permit_action(:destroy) }
    it { is_expected.not_to permit_action(:update) }
    it { is_expected.not_to permit_action(:edit) }
  end
end
