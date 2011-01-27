# == Schema Information
# Schema version: 20110119171126
#
# Table name: addresses
#
#  id            :integer         not null, primary key
#  country_id    :integer
#  region_id     :integer
#  city          :string(255)
#  zip           :string(255)
#  street        :string(255)
#  street_number :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Address < ActiveRecord::Base
end
