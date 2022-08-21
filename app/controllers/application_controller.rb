# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_query

  def set_query
    @q = User.ransack(params[:q])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :full_name, :avatar, :status) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:full_name, :bio, :password)
    end
  end
end
