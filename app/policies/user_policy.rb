class UserPolicy < ApplicationPolicy
  # CRUD Methods: Allow or deny actions


  def index?
    # Only admins can see all users
    admin?
  end

  def show?
    # Admins can see any user, members can see only themselves
    admin? || own_profile?
  end

  def create?
    # Only admins can create users (via admin panel)
    # Devise handles user registration separately
    admin?
  end

  def update?
    # Admins can edit any user, members can edit only themselves
    admin? || own_profile?
  end

  def edit?
    update?
  end

  def destroy?
    # Only admins can delete users
    admin?
  end


  # Scope: Filter users visible to current user


  class Scope < ApplicationPolicy::Scope
    def resolve
      if @user&.admin?
        # Admins see all users
        @scope.all
      elsif @user&.member?
        # Members see only themselves
        @scope.where(id: @user.id)
      else
        # Not logged in? See nothing
        @scope.none
      end
    end
  end


  # Private Helpers


  private

  def own_profile?
    # Check if the user being accessed is the current user
    record.id == user&.id
  end
end
