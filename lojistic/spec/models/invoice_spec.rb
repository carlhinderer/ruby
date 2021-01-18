describe Invoice, type: :model do
  let(:invoice) { build :invoice }
  let(:package_1) { build :package, service_name: 'Amazon' }
  let(:package_2) { build :package, service_name: 'Walmart' }
  let(:package_3) { build :package, service_name: 'Walmart' }
  let(:invoice_with_packages) { invoice.packages << [package_1, package_2, package_3] }

  describe "Associations" do
    it "should have many packages" do
      invoice.packages << [package_1, package_2]
      expect(invoice.packages).to include package_1
      expect(invoice.packages).to include package_2
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
    it "returns 0 if there are no associated packages" do
      expect(invoice.num_unique_services).to eq 0
    end

    it "returns the correct number of unique services if associated packages" do
      invoice.packages << [package_1, package_2, package_3]
      expect(invoice.num_unique_services).to eq 2
    end
  end
end