class CreateAcceptanceTests < ActiveRecord::Migration
  def self.up
    create_table :acceptance_tests do |t|
      t.integer :user_story_id
      t.boolean :fulfilled
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :acceptance_tests
  end
end
