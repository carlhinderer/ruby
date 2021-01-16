require 'csv'

class InvoiceSummaryReportCreateJob < ApplicationJob
  queue_as :default

  CSV_HEADERS = ['InvoiceType', 'Date', 'Amount', 'ReferenceNumber', 
    'NumberOfPackages', 'UniqueServices']

  def perform(report)
    path = Rails.root.join('storage')
    filename = "InvoiceSummary-#{report.start_date}-#{report.end_date}.csv"
    CSV.open(path.join(filename), 'wb') do |csv|
      csv << CSV_HEADERS
      report.invoice_list.each do |i|
        row = [i.invoice_type, 
               i.date, 
               i.amount, 
               i.reference_number, 
               i.packages.count,
               i.num_unique_services]
        csv << row
      end
    end
  end
end