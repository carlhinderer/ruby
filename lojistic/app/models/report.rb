class Report < ApplicationRecord
  attribute :deleted, default: :false
  REPORT_TYPES = ['InvoiceSummary']

  validates :report_type, :start_date, :end_date, presence: true
  validates :report_type, inclusion: REPORT_TYPES
  validates_with ReportDatesValidator

  has_one_attached :csv_report
  
  def soft_delete
    self.update(:deleted => true) 
  end

  def invoice_list
    Invoice.created_between(self.start_date, self.end_date).order(:date)
  end

  def self.preview(begin_date, end_date)
    Invoice.created_between(begin_date, end_date).order(:date).take(50)
  end

end