# == Schema Information
# Schema version: 20110303114312
#
# Table name: projects
#
#  id                :integer         not null, primary key
#  name              :string(255)
#  organisation_type :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  user_id           :integer
#  product_id        :integer
#

class Project < ActiveRecord::Base
  include StructuralItem::Model
  attr_reader :realm
  
  after_create :specify_for_organisation_type
  
  belongs_to :user
  belongs_to :statusable
  belongs_to :product
  has_one :backlog, :dependent => :destroy
  has_many :sprints, :through => :backlog
  has_many :features, :as => :featurable, :dependent => :destroy
  has_many :tasks, :as => :taskable, :dependent => :destroy
  has_many :assignments, :as => :assignable
  has_many :assigned_users, :through => :assignments, :source => :user
  # has_and_belongs_to_many :members, :class_name => "User", 
  #                                   :association_foreign_key => "user_id", 
  #                                   :join_table => "projects_members"
  
  
  validates :name, :presence => true
  validates :user, :presence => true
  validates :product, :presence => true
  validates :organisation_type, :presence => true
  
  holder :product
  
  def realm
    product.realm
  end
  
  def crowd
    assigned_users
  end
  
  def assigned_users= assigned_users_hash
    self.assignments.destroy_all
    assigned_users_hash.each do |u_id|
      u = User.find(u_id)
      self.assignments.build(:user => u)
    end
  end
  
  def self.organisation_types
    ['scrum_based', 'feature_based', 'task_based', 'flat']
  end
  
  private 
  def specify_for_organisation_type
    if self.organisation_type == 'scrum_based'
      self.backlog = Backlog.create()
    end
  end
end
