module ReportsHelper
  def download_link(report)
    if report.csv_report.attachment
      link_to report.csv_report.filename, 
        rails_blob_url(report.csv_report, disposition: 'attachment')
    else
      'Report pending creation.'
    end
  end
end