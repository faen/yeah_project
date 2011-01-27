# == Schema Information
# Schema version: 20110119171126
#
# Table name: projects
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  product_id :integer
#

class Project < ActiveRecord::Base
  # attr_accessor :user_id, :member_id, :users, :members
  attr_reader :realm
  
  belongs_to :product
  belongs_to :user
  has_and_belongs_to_many :members, :class_name => "User", 
                                    :association_foreign_key => "user_id", 
                                    :join_table => "projects_members"
  
  
  validates :name, :presence => true
  validates :user, :presence => true
  validates :product, :presence => true
  
  def realm
    product.realm
  end
  
  private 
    
end
