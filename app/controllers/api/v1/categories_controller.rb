class Api::V1::CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    categories = Category.all
    render json: categories
  end

  def create
    category = Category.new(category_params)
    render json: category, status: :created
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
