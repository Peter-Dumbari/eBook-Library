class Borrow < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :book, presence: true
  validates :book_id, uniqueness: true
end
