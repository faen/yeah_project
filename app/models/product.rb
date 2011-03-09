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
  
  validates :name, :presence => true
  validates :user, :presence => true
  validates :realm, :presence => true
  
  holder :realm
end
