describe Report, type: :model do
  let(:report) { create :report, start_date: 10.days.ago, end_date: 5.days.ago }
  let!(:invoice_within_range_1) { create :invoice, date: 8.days.ago }
  let!(:invoice_within_range_2) { create :invoice, date: 7.days.ago }
  let!(:invoice_outside_range) { create :invoice, date: 15.days.ago }
  
  describe "Validations" do
    it "it is valid with valid attributes" do
      expect(report).to be_valid
    end

    it "is not valid without a report type" do
      report.report_type = nil
      expect(report).to_not be_valid
    end

    it "is not valid with an unrecognized report type" do
      report.report_type = 'FakeReport'
      expect(report).to_not be_valid
    end

    it "is not valid without a start date" do
      report.start_date = nil
      expect(report).to_not be_valid
    end

    it "is not valid without an end date" do
      report.end_date = nil
      expect(report).to_not be_valid
    end

    it "is not valid if the end date comes before the start date" do
      report.start_date = 1.days.ago
      report.end_date = 2.days.ago
      expect(report).to_not be_nil
    end
  end

  describe "#soft_delete" do
    it "should not be soft deleted by default when created" do
      expect(report.deleted).to be false
    end

    it "should be soft deleted when the method is called" do
      report.soft_delete
      expect(report.deleted).to be true
    end
  end

  describe "#invoice_list" do
    it "should return the invoices within the date range in sorted order" do
      expect(report.invoice_list.first).to eq invoice_within_range_1
      expect(report.invoice_list.last).to eq invoice_within_range_2
      expect(report.invoice_list).to_not include invoice_outside_range
    end
  end

  describe "#preview" do
    it "should return the invoices within the date range in sorted order" do
      start_date = 10.days.ago
      end_date = 5.days.ago
      expect(Report.preview(start_date, end_date).first).to eq invoice_within_range_1
      expect(Report.preview(start_date, end_date).last).to eq invoice_within_range_2
      expect(Report.preview(start_date, end_date)).to_not include invoice_outside_range
    end
  end
end