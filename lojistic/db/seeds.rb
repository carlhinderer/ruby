# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

NUMBER_OF_INVOICES = 20

def create_fake_invoices()
  NUMBER_OF_INVOICES.times do
    invoice_date = Date.today - rand(1..30)
    invoice_type = Invoice::INVOICE_TYPES.sample
    amount = rand(1..100)
    reference_number = Faker::Barcode::isbn

    Invoice.create(invoice_type: invoice_type,
                   date: invoice_date, 
                   amount: amount,
                   reference_number: reference_number)
  end
end

def create_fake_packages()
  Invoice.all.each do |i|
    num_packages = rand(1..10)
    num_packages.times do
      tracking_number = Faker::Barcode::isbn
      service_name = Package::SERVICE_NAMES.sample

      package = Package.new(tracking_number: tracking_number,
                            service_name: service_name,
                            ship_date: i.date,
                            expected_delivery_date: i.date + rand(1..5))
      i.packages << package
    end
  end
end

create_fake_invoices
create_fake_packages