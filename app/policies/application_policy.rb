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
    owner?
  end

  def new?
    true
  end

  def update?
    owner?
  end

  def edit?
    true
  end

  def destroy?
    owner?
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
end
