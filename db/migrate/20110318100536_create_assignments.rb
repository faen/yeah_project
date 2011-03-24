class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.integer :assignable_id
      t.string :assignable_type
      t.integer :user_id
      t.string :role

      t.timestamps
    end
  end

  def self.down
    drop_table :assignments
  end
end
