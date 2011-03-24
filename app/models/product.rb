# == Schema Information
# Schema version: 20110119171126
#
# Table name: products
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  realm_id   :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Product < ActiveRecord::Base
  include StructuralItem::Model
  
  has_many :projects, :dependent => :destroy
  belongs_to :user
  belongs_to :realm
  has_many :assignments, :as => :assignable
  has_many :assigned_users, :through => :assignments, :source => :user
  
  validates :name, :presence => true
  validates :user, :presence => true
  validates :realm, :presence => true
  
  def assigned_users= assigned_users_hash
    self.assignments.destroy_all
    assigned_users_hash.each do |u_id|
      u = User.find(u_id)
      self.assignments.build(:user => u)
    end
  end
  
  def crowd
    c = assigned_users + projects.map{|p| p.assigned_users}.reject{|i| i.empty? }
    c.flatten.uniq.compact
  end
  
  holder :realm
  
end
