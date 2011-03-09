# == Schema Information
# Schema version: 20110119171126
#
# Table name: user_profiles
#
#  id            :integer         not null, primary key
#  user_id       :integer
#  firstname     :string(255)
#  lastname      :string(255)
#  gender        :string(255)
#  date_of_birth :date
#  created_at    :datetime
#  updated_at    :datetime
#

class UserProfile < ActiveRecord::Base
  belongs_to :user
  
  validates :user, :presence => true
  validates :firstname, :presence => true
  validates :lastname, :presence => true
  validates :date_of_birth, :presence => true
  
  def name
    "#{self.firstname} #{self.lastname}"
  end
end
