class CreateFeatures < ActiveRecord::Migration
  def self.up
    create_table :features do |t|
      t.string :name
      t.text :description
      t.integer :featurable_id
      t.string :featurable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :features
  end
end
