# == Schema Information
# Schema version: 20110309130152
#
# Table name: acceptance_tests
#
#  id            :integer         not null, primary key
#  user_story_id :integer
#  fulfilled     :boolean
#  description   :text
#  created_at    :datetime
#  updated_at    :datetime
#

class AcceptanceTest < ActiveRecord::Base
  belongs_to :user_story
end
