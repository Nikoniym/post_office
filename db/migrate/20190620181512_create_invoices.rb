class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.integer :company_code
      t.integer :operation_number
      t.date :operation_date
      t.references :parcel_list, foreign_key: true

      t.timestamps
    end
  end
end
