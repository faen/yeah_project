class CreateBacklogs < ActiveRecord::Migration
  def self.up
    create_table :backlogs do |t|
      t.integer :project_id
      t.integer :default_sprint_weeks, :default => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :backlogs
  end
end
