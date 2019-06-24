class Product < ApplicationRecord
  belongs_to :invoice

  validates :price, length: { maximum: 90_000 }, presence: true
  validates :quantity, length: { maximum: 50 }, presence: true
  validates :parcel_code, uniqueness: true, format: { with: /^[0-9]+$/, multiline: true, message: "%{value} is not a valid format" }
end
