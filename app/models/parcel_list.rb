class ParcelList < ApplicationRecord
  has_many :invoices

  validates :batch_id, length: { is: 7 }, uniqueness: true, presence: true
end
