# == Schema Information
# Schema version: 20110119171126
#
# Table name: organisations
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Organisation < ActiveRecord::Base
end
