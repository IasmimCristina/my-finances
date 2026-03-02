class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[show edit update destroy]

  def index
    authorize User
    @users = policy_scope(User)
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
    redirect_to users_url, notice: "User was successfully deleted."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user!
    authorize @user
  end

  def user_params
    permitted_attrs = %i[name email password password_confirmation]
    permitted_attrs << :role if current_user.admin?
    params.require(:user).permit(permitted_attrs)
  end
end
