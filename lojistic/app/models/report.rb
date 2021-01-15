class Report < ApplicationRecord
  REPORT_TYPES = ['InvoiceSummary']

  validates :report_type, :start_date, :end_date, :deleted, presence: true
  validates :report_type, inclusion: REPORT_TYPES
  
  def soft_delete()
    self.update(:deleted => :true) 
  end
end