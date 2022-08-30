# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'validates presence' do
    user = described_class.new
    user.email = ''
    user.validate
    expect(user.errors[:email]).to include("can't be blank")

    # user.email = 'foo@bar.com'
    # user.validate
    # expect(user.errors[:email]).not_to include("can't be blank")
  end
end
