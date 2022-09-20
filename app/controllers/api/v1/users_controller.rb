# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def followers
        @followers = User.find_by(id: params[:id]).followers
        if @followers.present?
          render json: { data: ActiveModelSerializers::SerializableResource.new(@followers,
                                                                                each_serializer: UserSerializer),
                         message: ['User followers fetched successfully'],
                         status: 200,
                         type: 'Success' }
        else
          render json: { message: 'User followers not found.' }, status: :not_found
        end
      end
    end
  end
end
