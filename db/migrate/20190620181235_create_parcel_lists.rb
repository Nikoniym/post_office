class CreateParcelLists < ActiveRecord::Migration[5.2]
  def change
    create_table :parcel_lists do |t|
      t.string :guid
      t.integer :batch_id, unique: true
      t.date :creation_date

      t.timestamps
    end
  end
end
