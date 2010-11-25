class ProjectsMembers < ActiveRecord::Migration
  def self.up
    create_table :projects_members, :id => false do |t|
      t.references :user
      t.references :project
      t.references :role
    end
  end

  def self.down
    drop_table :projects_members
  end
end
