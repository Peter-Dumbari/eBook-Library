class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :book, presence: true
  validates :book_id, uniqueness: { message: 'book has already been borrowed' }
end
