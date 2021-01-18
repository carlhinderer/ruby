FactoryBot.define do
  factory :invoice do
    invoice_type { 'Fedex' }
    date { Date.current }
    amount { 10 }
    reference_number { '123ABC' }
  end

  factory :package do
    service_name { 'Amazon' }
    tracking_number { '456DEF' }
    ship_date { 10.days.ago }
    expected_delivery_date { 5.days.ago }
    delivery_date { 3.days.ago }
    invoice
  end
end