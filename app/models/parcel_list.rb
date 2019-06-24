class ParcelList < ApplicationRecord
  has_many :invoices

  validates :batch_id, length: { is: 6 }, uniqueness: true, presence: true

  attr_accessor :file
end
