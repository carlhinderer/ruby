describe Invoice, type: :model do
  let(:invoice) { create :invoice }
  let!(:package_1) { create :package, service_name: 'Amazon', invoice: invoice }
  let!(:package_2) { create :package, service_name: 'Walmart', invoice: invoice }
  let!(:package_3) { create :package, service_name: 'Walmart', invoice: invoice }


  describe "Associations" do
    it "should have many packages" do
      expect(invoice.packages.count).to eq 3
    end
  end

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(invoice).to be_valid
    end

    it "is not valid without an invoice type" do
      invoice.invoice_type = nil
      expect(invoice).to_not be_valid
    end

    it "is not valid with an unrecognized invoice type" do
      invoice.invoice_type = 'FakeShipping'
      expect(invoice).to_not be_valid
    end

    it "is not valid without a date" do
      invoice.date = nil
      expect(invoice).to_not be_valid
    end

    it "is not valid without an amount" do
      invoice.amount = nil
      expect(invoice).to_not be_valid
    end

    it "is not valid without a reference number" do
      invoice.reference_number = nil
      expect(invoice).to_not be_valid
    end
  end

  describe "#num_unique_services" do
    it "returns the correct number of unique services if associated packages" do
      expect(invoice.num_unique_services).to eq 2
    end
  end
end