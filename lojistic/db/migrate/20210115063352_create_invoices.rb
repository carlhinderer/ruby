class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.string :invoice_type
      t.datetime :date
      t.integer :amount
      t.string :reference_number
      t.timestamps
    end

    add_index :invoices, :date
  end
end