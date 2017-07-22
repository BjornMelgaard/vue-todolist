class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    raise Errors::Unauthenticated, 'Unauthorized: must be logged in' unless user
    @user = user
    @record = record
  end

  def show?
    scope.where(id: record.id).exists?
  end

  def create?
    true
  end

  def update?
    show?
  end

  def destroy?
    update?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      raise Errors::Unauthenticated, 'Unauthorized: must be logged in' unless user
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
