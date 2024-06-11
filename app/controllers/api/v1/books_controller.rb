class Api::V1::BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    books = Book.includes(:image)
    render json: books, include: %i[image]
  end

  def show
    book = Book.find(params[:id])
    render json: book
  end

  def create
    book = Book.new(book_params)
    if book.save
      attach_image(book)
      render json: book, status: :created
    else
      render json: book.errors, status: :unprocessable_entity
    end
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      attach_image(book)
      render json: book, status: :ok
    else
      render json: book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    head :no_content
  end

  private

  def attach_image(book)
    return unless params[:book][:image_file].present?

    book.image ||= book.build_image
    book.image.image_file.attach(params[:book][:image_file])
    book.image.save
  end

  def book_params
    params.require(:book).permit(:title, :author, :description, :category_id, :recommended,
                                 image_attributes: %i[id image_file])
  end
end
