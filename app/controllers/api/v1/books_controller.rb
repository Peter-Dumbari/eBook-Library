class Api::V1::BooksController < ApplicationController
  before_action :authenticate_user!
  # load_and_authorize_resource

  def index
    books = Book.includes(:image, :category).order(created_at: :desc)
    render json: books, include: %i[image category]
  end

  def show
    book = Book.find(params[:id])
    render json: book
  end

  def fetch_by_title
    title = params[:title]
    books = Book.where('title ILIKE ?', "%#{title}%")

    if books.present?
      render json: books, include: %i[image category], status: :ok
    else
      render json: { message: 'No books found' }, status: :not_found
    end
  end

  def fetch_by_category
    category_id = params[:category_id]
  
    if category_id.present?
      books = Book.includes(:category)
                  .where(categories: { id: category_id }, recommended: true)
                  .distinct
  
      if books.any?
        render json: books, include: %i[image category]
      else
        render json: { error: 'No books found for the given category and recommendation status' }, status: :not_found
      end
    else
      render json: { error: 'Category ID is required' }, status: :unprocessable_entity
    end
  end
  

  def create
    book = Book.new(book_params.except(:image_file))

    if book.save
      attach_image(book) if params[:book][:image_file].present?
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
      render json: {
        message: 'Book cannot be deleted because it is reserved or borrowed'
      }, status: :unprocessable_entity
    else
      book.destroy
      render json: { message: 'Book deleted successfully' }, status: :success
    end
  end

  private

  def attach_image(book)
    image_url = params[:book][:image_file]
    return unless image_url.present?

    book.build_image(image_data: image_url)
    return if book.image.save

    render json: book.image.errors, status: :unprocessable_entity and return
  end

  def book_params
    params.require(:book).permit(:title, :author, :description, :file_url, :category_id, :recommended,
                                 :image_file)
  end
end
