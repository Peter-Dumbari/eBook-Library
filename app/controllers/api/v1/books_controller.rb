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
    book = Book.new(book_params.except(:image_file))
    attach_image(book) if params[:book][:image_file].present?

    if book.save
      render json: { book:, status: :created, message: 'Book created successfully' }
    else
      render json: book.errors, status: :unprocessable_entity
    end
  end

  def update
    book = Book.find(params[:id])
    attach_image(book) if params[:image_file].present?

    if book.update(book_params.except(:image_file))
      render json: { book:, status: :ok, message: 'Book updated successfully' }
    else
      render json: book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    book = Book.find(params[:id])

    if book.reserved? || book.borrowed?
      render json: { status: :unprocessable_entity,
                     message: 'Book cannot be deleted because it is reserved or borrowed' }
    else
      book.destroy
      render json: { status: :success, message: 'Book deleted successfully' }
    end
  end

  private

  def attach_image(book)
    image_url = params[:book][:image_file]
    book.build_image(image_data: image_url)
    return if book.image.save

    render json: book.image.errors, status: :unprocessable_entity and return
  end

  def book_params
    params.require(:book).permit(:title, :author, :description, :file_url, :category_id, :recommended,
                                 :image_file)
  end
end
