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
  belongs_to :user
  has_many :products
  
  attr_accessible :name, :user
  
  validates :name, :presence => true
  validates :user, :presence => true
end
