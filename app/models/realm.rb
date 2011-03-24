# == Schema Information
# Schema version: 20110119171126
#
# Table name: realms
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Realm < ActiveRecord::Base
  include StructuralItem::Model
  belongs_to :user
  has_many :products, :dependent => :destroy
  has_many :assignments, :as => :assignable
  has_many :assigned_users, :through => :assignments, :source => :user
  
  attr_accessible :name, :user
  
  validates :name, :presence => true
  validates :user, :presence => true
  
  def crowd
    c = assigned_users + products.map{|p| p.crowd }.reject{|i| i.empty? }
    c.flatten.uniq.compact
  end
end
