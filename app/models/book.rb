class Book < ApplicationRecord
  belongs_to :category
  has_many :borrows
  has_many :reservations
  has_one :image, dependent: :destroy
  accepts_nested_attributes_for :image
end
