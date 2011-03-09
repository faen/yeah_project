class CreateUserStories < ActiveRecord::Migration
  def self.up
    create_table :user_stories do |t|
      t.string :name
      t.string :role
      t.string :goal
      t.string :benefit
      t.integer :story_points
      t.integer :priority
      t.integer :feature_id
      
      t.integer :backlog_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :user_stories
  end
end
