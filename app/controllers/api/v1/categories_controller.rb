class Api::V1::CategoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    categories = Category.all.order(created_at: :desc)
    render json: categories
  end

  def create
    category = Category.new(category_params)

    if category.save
      render json: { category:, message: 'Category added succefully' }, status: :created
    else
      render json: { Error: category.error, message: 'Something was wrong' }, status: :unprocessable_entity
    end
  end

  def update
    category = Category.find(params[:id])

    if category.update(category_params)
      render json: { category:, message: 'Category updated successfully' }, status: :ok
    else
      render json: { error: category.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy

    if category.destroy
      render json: { message: 'Category deleted successfully' }, status: :ok

    else
      render json: category.errors, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
