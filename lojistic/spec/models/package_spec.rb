describe Package, type: :model do
  let(:invoice) { build :invoice }
  let(:package) { build :package, invoice: invoice }

  describe "Associations" do
    it "belongs to the invoice" do
      expect(package.invoice).to be invoice
    end
  end

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(package).to be_valid
    end
  
    it "is not valid without a tracking number" do
      package.tracking_number = nil
      expect(package).to_not be_valid
    end
  
    it "is not valid without a service name" do
      package.service_name = nil
      expect(package).to_not be_valid
    end
  
    it "is not valid with an unrecognized service name" do
      package.service_name = 'Kroger'
      expect(package).to_not be_valid
    end
  
    it "is not valid without an invoice" do
      package.invoice = nil
      expect(package).to_not be_valid
    end
  end

end