class AssociateProjectToUserAndProduct < ActiveRecord::Migration
  def self.up
    add_column :projects, :user_id, :integer
    add_column :projects, :product_id, :integer
  end

  def self.down
    remove_column :projects, :user_id
    remove_column :projects, :product_id
  end
end
