class Product < ApplicationRecord
  belongs_to :invoice

  validates :price

  validates :price, length: { maximum: 90_000 }, presence: true
  validates :quantity, length: { maximum: 50 }, presence: true
  validates :parcel_code, uniqueness: true, format: { with: /^[0-9]+$/ }
end
