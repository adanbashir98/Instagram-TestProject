# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def edit?
    user.present? && (record.user == user)
  end

  def update?
    user.present? && (record.user == user)
  end

  def destroy?
    user.present? && (record.user == user)
  end
end
