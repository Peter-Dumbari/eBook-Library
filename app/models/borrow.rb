class Borrow < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :book, presence: true
  # validates :book_id, uniqueness: { scope: :user_id, message: "has already been borrowed by you" }
end
