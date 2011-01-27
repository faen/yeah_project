# == Schema Information
# Schema version: 20110119171126
#
# Table name: regions
#
#  id           :integer         not null, primary key
#  country_id   :integer         not null
#  name         :string(45)      not null
#  code         :string(8)       not null
#  adm1code     :string(4)       not null
#  country_ison :string(4)       not null
#  created_at   :datetime
#  updated_at   :datetime
#

class Region < ActiveRecord::Base
  belongs_to :country
end
