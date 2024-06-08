class Api::V1::BorrowsController < ApplicationController
    before_action :authenticate_user!

    def index
        borrows = current_user.borrows
        render json: borrows
    end


    def create
        book = Book.find(params[:book_id])
        borrow = current_user.borrows.build(book: book, due_date: 2.weeks_from_now)

        if borrow.save
            render json: { borrow: borrow, message: "Borrowed successfully" }, status: :created

        else
            render json: borrow.errors, status: :unprocessable_entity
        end
    end


    def destroy
        borrow = current_user.borrows.find(params[:id])
        borrow.destroy
        head :no_content
    end


    private

    def borrow_params
        params.require(:borrow).permit(:book_id)
    end
end
