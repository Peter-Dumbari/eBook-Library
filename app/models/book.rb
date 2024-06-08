class Book < ApplicationRecord
  belongs_to :category
  has_many :borrows
  has_many :reservations
end
