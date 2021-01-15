class Invoice < ApplicationRecord
  has_many :packages
end