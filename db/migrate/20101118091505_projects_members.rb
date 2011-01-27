class ProjectsMembers < ActiveRecord::Migration
  def self.up
    create_table :projects_members, :id => false do |t|
      t.references :user
      t.references :project
      t.references :role
    end
    add_index 'projects_members', 'user_id'
    add_index 'projects_members', 'project_id'
  end

  def self.down
    drop_table :projects_members
  end
end
