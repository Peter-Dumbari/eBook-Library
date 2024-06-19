class Api::V1::BorrowsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    borrows = current_user.borrows.includes(book: :image)
    render json: borrows, include: { book: { include: :image } }
  end

  def destroy
    borrow = current_user.borrows.find(params[:id])

    if borrow.destroy
      render json: { status: :ok, message: 'Book return sucessfully' }

    else
      render json: { message: 'Something went wrong' }, status: :unprocessable_entity

    end
  end

  def create
    book = Book.find_by(id: borrow_params[:book_id])

    if book.nil?
      render json: { error: 'Book not found' }, status: :not_found
      return
    end

    borrow = current_user.borrows.build(book:book, due_date: 2.weeks.from_now)

    if borrow.save
      render json: { borrow:borrow, message: 'Book borrowed successfully' }, status: :created
    else
      Rails.logger.debug borrow.errors.full_messages.join(', ')
      render json: { errors: borrow.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def borrow_params
    params.require(:borrow).permit(:book_id)
  end
end
