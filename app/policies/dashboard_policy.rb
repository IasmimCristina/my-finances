class DashboardPolicy < ApplicationPolicy
  def show?
    user.present?
  end

  alias_method :dashboard?, :show?
end
