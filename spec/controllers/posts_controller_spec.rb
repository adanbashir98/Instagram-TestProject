# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:post1) { FactoryBot.create(:post, user_id: user.id) }
  let(:user_not_authorized) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  describe 'when post#create' do
    context 'when cases' do
      let!(:post_params) do
        { content: 'Heyy.',
          images: [Rack::Test::UploadedFile.new(Rails.root.join('spec/images/test.png'), 'image/png')] }
      end

      let!(:invalid_post_params) do
        { content: nil, images: nil }
      end

      it 'creates post' do
        post :create, params: { post: post_params }
        expect(flash[:notice]).to match('Post was successfully created.')
      end

      it 'does not create post' do
        post :create, params: { post: invalid_post_params }
        expect(flash[:alert]).to match('Something went wrong. Try again!')
      end
    end
  end

  describe 'when post#update' do
    let!(:invalid_post_params) do
      { content: nil }
    end

    let!(:valid_post_params) do
      { content: 'Whatt?' }
    end

    it 'updates a post' do
      patch :update, params: { id: post1.id, post: valid_post_params }
      expect(flash[:notice]).to match('Post edited!')
    end

    it 'does not update a post' do
      patch :update, params: { id: post1.id, post: invalid_post_params }
      expect(flash[:alert]).to match('Something went wrong. Try Again!')
    end

    it 'does not authorise a user to update a post' do
      sign_in user_not_authorized
      patch :update, params: { id: post1.id, post: valid_post_params, user_id: user_not_authorized.id }
      expect(flash[:alert]).to match('You are not authorized to perform this action.')
    end
  end

  describe 'when post#delete' do
    it 'destroys a post' do
      delete :destroy, params: { id: post1.id }
      expect(flash[:notice]).to match('Post is deleted!')
    end

    it 'does not destroy a post' do
      allow_any_instance_of(Post).to receive(:destroy).and_return(false)
      delete :destroy, params: { id: post1.id }
      expect(flash[:alert]).to match('Something went wrong. Try Again!')
    end

    it 'does not authorise a user to destroy a post' do
      sign_in user_not_authorized
      delete :destroy, params: { id: post1.id, user_id: user_not_authorized.id }
      expect(flash[:alert]).to match('You are not authorized to perform this action.')
    end
  end
end
