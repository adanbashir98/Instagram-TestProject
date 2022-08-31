# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def record_not_found
    flash[:alert] = 'This record was not found.'
    redirect_to root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :full_name, :avatar, :status) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:full_name, :bio, :password, :current_password, :avatar)
    end
  end

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to root_path
  end
end
