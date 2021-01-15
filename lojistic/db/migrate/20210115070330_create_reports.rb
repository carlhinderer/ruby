class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.string :type
      t.date :start_date
      t.date :end_date
      t.boolean :deleted
      t.timestamps
    end
  end
end
