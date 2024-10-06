# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    owner_or_admin?
  end

  def new?
    true
  end

  def update?
    owner_or_admin?
  end

  def edit?
    true
  end

  def destroy?
    owner_or_admin?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(user_id: user.id)
    end

    private

    attr_reader :user, :scope
  end

  private

  def owner?
    record.user_id == user.id
  end

  def admin?
    user.admin?
  end

  def owner_or_admin?
    owner? || admin?
  end
end
