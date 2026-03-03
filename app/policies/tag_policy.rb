class TagPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present?
  end

  def create?
    admin? || false
  end

  def new?
    create?
  end

  def update?
    admin? || false
  end

  def edit?
    update?
  end

  def destroy?
    admin? || false
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if @user&.admin?
        @scope.all
      elsif @user&.member?
        @scope.all  # Tudo pe visualizado, ma snão é editado!!
      else
        @scope.none
      end
    end
  end
end
