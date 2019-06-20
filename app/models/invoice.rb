class Invoice < ApplicationRecord
  belongs_to :parcel_list
  has_many :products

  validates :number, length: { maximum: 9 }, uniqueness: true, presence: true
  validates :company_code, length: { maximum: 4 }, presence: true

  validate :product_count

  def product_count
    errors.add(:product_count, "too much") if products.size > 5
  end
end
