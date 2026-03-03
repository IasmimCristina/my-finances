class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]
  before_action :authorize_category!, only: %i[show edit update destroy]
  # Center policies:
  before_action :set_category_permissions, only: %i[index show]

  def index
    authorize Category
    @categories = policy_scope(Category).ordered
    @can_create = policy(Category).create?
  end

  def show
    @can_edit = policy(@category).update?
    @can_delete = policy(@category).destroy?
  end

  def new
    @category = Category.new
    authorize @category
  end

  def create
    @category = Category.new(category_params)
    authorize @category

    if @category.save
      redirect_to @category, notice: "Categoria criada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to @category, notice: "Categoria atualizada com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy!
    redirect_to categories_url, notice: "Categoria deletada com sucesso."
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def authorize_category!
    authorize @category
  end

  def set_category_permissions
    @can_create = policy(Category).create?
    @can_edit = policy(@category).update? if @category
    @can_delete = policy(@category).destroy? if @category
  end

  def category_params
    params.require(:category).permit(:name, :description, :color, :kind)
  end
end
