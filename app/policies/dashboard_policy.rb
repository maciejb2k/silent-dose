class DashboardPolicy < ApplicationPolicy
  def index?
    owner?
  end

  def show?
    owner?
  end

  def create?
    owner?
  end

  def new?
    owner?
  end

  def update?
    owner?
  end

  def edit?
    owner?
  end

  def destroy?
    owner?
  end

  private

  def owner?
    record.user_id == user.id
  end
end
