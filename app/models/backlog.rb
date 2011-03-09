# == Schema Information
# Schema version: 20110303114312
#
# Table name: backlogs
#
#  id         :integer         not null, primary key
#  project_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Backlog < ActiveRecord::Base
  include StructuralItem::Model
  has_many :features, :as => :featurable, :dependent => :destroy
  has_many :user_stories, :dependent => :destroy
  belongs_to :project
  
  holder :project
  
  def name
    "Backlog"
  end
  
end
