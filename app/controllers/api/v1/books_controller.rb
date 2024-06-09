class Api::V1::BooksController < ApplicationController
    before_action :authenticate_user!

    
    def index
        books = Book.all
        render json: books
    end

    def show
        book = Book.find(params[:id]);
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


    def book_params
        params.require(:book).permit(:title, :author, :description, :category_id, :recommended, image_attributes: [:id, :image_file])    
    end
end
