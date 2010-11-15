class CreateEmailAcknowledgements < ActiveRecord::Migration
  def self.up
    create_table :email_acknowledgements do |t|
      t.string :token
      t.datetime :expire_date
      t.string :ack_state
      t.integer :email_acknowledgeable_id
      t.string :email_acknowledgeable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :email_acknowledgements
  end
end
