class UserPolicy < ApplicationPolicy
  def create?
    owner?
  end

  def update?
    owner?
  end

  def destroy?
    false
  end

  class Scope < Scope
    def resolve
      scope.where(id: user)
    end
  end

  private

  def owner?
    record.id == user.id
  end
end
