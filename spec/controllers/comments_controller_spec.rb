# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:post1) { FactoryBot.create(:post, user_id: user.id) }
  let(:comment) { FactoryBot.create(:comment, user_id: user.id, post_id: post1.id) }
  let(:user_not_authorized) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  describe 'when comment#create' do
    context 'when cases' do
      let!(:comment_params) do
        { comment_body: 'Hiiii!.' }
      end

      let!(:invalid_comment_params) do
        { comment_body: nil }
      end

      it 'creates comment' do
        post :create, params: { comment: comment_params, post_id: post1.id }
        expect(flash[:notice]).to match('Comment created!')
      end

      it 'does not create a comment' do
        post :create, params: { comment: invalid_comment_params, post_id: post1.id }
        expect(flash[:alert]).to match('Something went wrong. Try Again!')
      end
    end
  end

  describe 'when comment#delete' do
    it 'destroys a comment' do
      delete :destroy, params: { id: comment.id }
      expect(flash[:notice]).to match('Comment is deleted!')
    end

    it 'does not destroy a comment' do
      allow_any_instance_of(Comment).to receive(:destroy).and_return(false)
      delete :destroy, params: { id: comment.id }
      expect(flash[:alert]).to match('Something went wrong. Try Again!')
    end

    it 'does not authorise a user to destroy a comment' do
      sign_in user_not_authorized
      delete :destroy, params: { id: comment.id }
      expect(flash[:alert]).to match('You are not authorized to perform this action.')
    end
  end
end
