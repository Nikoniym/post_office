class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :parcel_code, unique: true
      t.integer :quantity
      t.integer :price
      t.references :invoice, foreign_key: true

      t.timestamps
    end

    add_index :products, [:parcel_code, :quantity]
  end
end
