# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end


  # Default behavior: Admins can do anything


  def index?
    admin?
  end

  def show?
    admin?
  end

  def create?
    admin?
  end

  def new?
    create?
  end

  def update?
    admin?
  end

  def edit?
    update?
  end

  def destroy?
    admin?
  end


  # Helper methods


  protected

  def admin?
    user&.admin?
  end

  def member?
    user&.member?
  end

  def owner?
    record.respond_to?(:user_id) && record.user_id == user&.id
  end


  # Scope: filter records visible to user


  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      # Admins see everything, members see only their own records
      if @user&.admin?
        @scope.all
      elsif @user&.member? && @scope.respond_to?(:where)
        @scope.where(user_id: @user.id)
      else
        @scope.none
      end
    end

    private

    attr_reader :user, :scope
  end
end
