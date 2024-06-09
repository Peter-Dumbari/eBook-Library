class Api::V1::ReservationsController < ApplicationController
    before_action :authenticate_user!

    def index
        reservations = current_user.reservations, order(created_at: :desc)
        render json: reservations
    end

    def create
        book = Book.find(params[:book_id])
        reservation = current_user.reservation.build(book: book, reserved_until: 1.week_from_now)

        if reservation.save
            render json: reservation, status: :unprocessable_entity
            
        else
            render json: reservation.errors, status: :unprocessable_entity
        end
    end

    private

    def reservation_params
        params.require(:reservation).permit(:book_id)
    end
end
