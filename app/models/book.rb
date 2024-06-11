class Book < ApplicationRecord
  belongs_to :category
  has_many :borrows
  has_many :reservations
  has_one :image, dependent: :destroy
  accepts_nested_attributes_for :image

  # Validations
  validates :title, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :author, presence: true, length: { maximum: 255 }
  validates :published_date, presence: true
  validates :category_id, presence: true
end
