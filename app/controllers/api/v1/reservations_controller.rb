class Api::V1::ReservationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    reservations = current_user.reservations.includes(:book)
    render json: reservations, include: { book: { include: :image } }
  end

  def create
    book = Book.find_by(id: reservation_params[:book_id])

    if book.nil?
      render json: { error: 'Book not found' }, status: :not_found
      return
    end

    reservation = current_user.reservations.build(book:, reserved_until: 1.weeks.from_now)

    if reservation.save
      render json: { reservation:, message: 'Book reserved successfully' }, status: :created
    else
      Rails.logger.debug reservation.errors.full_messages.join(', ')
      render json: { errors: reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    reservation = current_user.reservations.find(params[:id])
    if reservation.destroy
      render json: { status: :ok, message: 'Book removed from reservation sucessfully' }

    else
      render json: { message: 'something went wrong' }, status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:book_id)
  end
end
