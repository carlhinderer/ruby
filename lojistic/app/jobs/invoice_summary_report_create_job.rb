require 'csv'

class InvoiceSummaryReportCreateJob < ApplicationJob
  queue_as :default

  CSV_HEADERS = ['InvoiceType', 
                 'Date', 
                 'Amount', 
                 'ReferenceNumber', 
                 'NumberOfPackages', 
                 'UniqueServices']

  PATH = Rails.root.join('storage')

  def perform(report)
    create_csv(report)
    attach_csv_to_report(report)
  end

  def create_csv(report)
    CSV.open(filepath(report), 'wb') do |csv|
      csv << CSV_HEADERS
      report.invoice_list.each do |i|
        csv << csv_row(i)
      end
    end
  end

  def attach_csv_to_report(report)
    report.csv_report.attach(
      io: File.open(filepath(report)),
      filename: filename(report),
      content_type: 'text/csv')
  end

  def filepath(report)
    PATH.join(filename(report))
  end

  def filename(report)
    "InvoiceSummary-#{report.start_date}-#{report.end_date}.csv"
  end

  def csv_row(invoice)
    [
      invoice.invoice_type,
      invoice.date, 
      invoice.amount,
      invoice.reference_number,
      invoice.packages.count,
      invoice.num_unique_services
    ]
  end
end