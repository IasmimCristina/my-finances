class TagsController < ApplicationController
  before_action :set_tag, only: %i[show edit update destroy]
  before_action :authorize_tag!, only: %i[show edit update destroy]
  # Center policy use here:
  before_action :set_tag_permissions, only: %i[index show]

  def index
    authorize Tag
    @tags = policy_scope(Tag).ordered
    @can_create = policy(Tag).create?
  end

  def show
    @can_edit = policy(@tag).update?
    @can_delete = policy(@tag).destroy?
  end

  def new
    @tag = Tag.new
    authorize @tag
  end

  def create
    @tag = Tag.new(tag_params)
    authorize @tag

    if @tag.save
      redirect_to @tag, notice: "Tag criada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      redirect_to @tag, notice: "Tag atualizada com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tag.destroy!
    redirect_to tags_url, notice: "Tag deletada com sucesso."
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def authorize_tag!
    authorize @tag
  end

  def set_tag_permissions
    @can_create = policy(Tag).create?
    @can_edit = policy(@tag).update? if @tag
    @can_delete = policy(@tag).destroy? if @tag
  end

  def tag_params
    params.require(:tag).permit(:name, :description, :color)
  end
end
