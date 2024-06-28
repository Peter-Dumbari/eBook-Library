class Book < ApplicationRecord
  belongs_to :category
  has_many :borrows
  has_many :reservations
  has_one :image, dependent: :destroy
  accepts_nested_attributes_for :image

  # Validations
  validates :title, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :author, presence: true, length: { maximum: 255 }
  validates :category_id, presence: true
  validates :file_url, presence: true
  validates :description, presence: true

  def reserved?
    reservations.exists?
  end

  def borrowed?
    borrows.exists?
  end

  def self.update_recommendations_for_user(user)
    preference = user.preference
    return unless preference

    # Update the recommended status for each book
    Book.where.not(category_id: preference).update_all(recommended: false)
    Book.where(category_id: preference).update_all(recommended: true)
  end
end
