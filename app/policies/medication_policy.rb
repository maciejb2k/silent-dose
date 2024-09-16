class MedicationPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def new?
    true
  end

  def update?
    true
  end

  def edit?
    true
  end

  def destroy?
    true
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end

  private

  def owner?
    record.user_id == user.id
  end
end
