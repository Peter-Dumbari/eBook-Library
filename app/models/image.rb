class Image < ApplicationRecord
  belongs_to :book
  has_one_attached :image_file

  validates :image_file, presence: true
end
