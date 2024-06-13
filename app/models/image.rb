class Image < ApplicationRecord
  belongs_to :book
  has_one :image

  validates :image_data, presence: true
end
