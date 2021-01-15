class Package < ApplicationRecord
  belongs_to :invoice

  SERVICE_NAMES = ['Amazon', 'eBay', 'Etsy', 'Shopify', 'Walmart']

  validates :tracking_number, :service_name, presence: true
  validates :service_name, inclusion: SERVICE_NAMES
end