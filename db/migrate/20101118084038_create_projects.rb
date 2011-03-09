class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.string :organisation_type #scrum_based, feature_based, task_based, flat
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
