class Project < ActiveRecord::Base
  attr_accessor :user_id, :member_id, :users, :members
  has_and_belongs_to_many :members, :class_name => "User", 
                                    :association_foreign_key => "user_id", 
                                    :join_table => "projects_members"
  
  private 
    
end
