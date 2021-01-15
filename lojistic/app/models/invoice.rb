class Invoice < ApplicationRecord
  has_many :packages

  INVOICE_TYPES = ['Fedex', 'UPS', 'Maersk', 'Hapag-Lloyd', 'COSCO']

  validates :invoice_type, :date, :amount, :reference_number, presence: true
  validates :invoice_type, inclusion: INVOICE_TYPES

  scope :created_between, -> (begin_date, end_date) {where(date: begin_date..end_date)}

  def num_unique_services
    2
  end
end