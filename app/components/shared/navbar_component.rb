module Shared
  class NavbarComponent < ViewComponent::Base
    def initialize
      @user = Current.user
    end

    def admin?
      @user&.admin?
    end

    def member?
      @user&.member?
    end

    def signed_in?
      @user.present?
    end
  end
end
