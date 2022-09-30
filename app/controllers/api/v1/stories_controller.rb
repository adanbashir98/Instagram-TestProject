# frozen_string_literal: true

module Api
  module V1
    class StoriesController < ApplicationController
      def index
        @stories = Story.all
        render json: {
          data: ActiveModelSerializers::SerializableResource.new(@stories,
                                                                 each_serializer: StorySerializer),
          message: ['Stories fetched successfully'],
          status: 200,
          type: 'Success'
        }
      end

      def show
        @story = Story.find_by(id: params[:id])
        if @story.present?
          render json: {
            data: ActiveModelSerializers::SerializableResource.new(@story,
                                                                   each_serializer: StorySerializer),
            message: ['Story fetched successfully'],
            status: 200,
            type: 'Success'
          }
        else
          render json: { message: 'Story not found.' }, status: :not_found
        end
      end
    end
  end
end
