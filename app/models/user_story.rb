# == Schema Information
# Schema version: 20110303114312
#
# Table name: user_stories
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  role          :string(255)
#  goal          :string(255)
#  benefit       :string(255)
#  tellable_id   :integer
#  tellable_type :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class UserStory < ActiveRecord::Base
  include StructuralItem::Model
  belongs_to :backlog
  has_many :tasks, :as => :taskable, :dependent => :destroy
  has_many :acceptance_tests, :dependent => :destroy
  
  holder :backlog
  
  def story
    "As a #{role} i want #{goal} so that #{benefit}"
  end
end
