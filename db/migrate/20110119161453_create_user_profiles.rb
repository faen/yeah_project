class CreateUserProfiles < ActiveRecord::Migration
  def self.up
    create_table :user_profiles do |t|
      t.integer :user_id
      t.string :firstname
      t.string :lastname
      t.string :gender
      t.date :date_of_birth

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
