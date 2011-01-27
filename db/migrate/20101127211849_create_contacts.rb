class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :phone
      t.string :mobile
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
