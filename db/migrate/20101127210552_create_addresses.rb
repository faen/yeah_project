class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.integer :country_id
      t.integer :region_id
      t.string :city
      t.string :zip
      t.string :street
      t.string :street_number

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
