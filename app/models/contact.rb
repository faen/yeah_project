# == Schema Information
# Schema version: 20110119171126
#
# Table name: contacts
#
#  id         :integer         not null, primary key
#  phone      :string(255)
#  mobile     :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Contact < ActiveRecord::Base
end
