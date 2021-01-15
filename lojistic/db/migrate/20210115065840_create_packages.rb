class CreatePackages < ActiveRecord::Migration[5.2]
  def change
    create_table :packages do |t|
      t.string :tracking_number
      t.string :service_name
      t.date :ship_date
      t.date :delivery_date
      t.date :expected_delivery_date
      t.belongs_to :invoice, foreign_key: true
      t.timestamps
    end
  end
end
