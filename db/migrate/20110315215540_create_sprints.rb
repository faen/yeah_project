class CreateSprints < ActiveRecord::Migration
  def self.up
    create_table :sprints do |t|
      t.integer :sprint_nr
      t.integer :backlog_id
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end

  def self.down
    drop_table :sprints
  end
end
