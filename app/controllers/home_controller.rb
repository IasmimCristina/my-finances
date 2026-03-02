class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]
  skip_before_action :set_current_user, only: [ :index ]

  def index
    redirect_to dashboard_path if user_signed_in?
  end

  def dashboard
    authorize Dashboard
  end
end
