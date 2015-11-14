class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.boolean :driver
      t.string :phone
      t.string :location
      t.integer :spots
      t.integer :plus_ones
      t.string :eventId
      t.string :eventTitle
      t.string :uuid

      t.timestamps null: false
    end
  end
end
