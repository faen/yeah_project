# == Schema Information
# Schema version: 20110315215540
#
# Table name: backlogs
#
#  id                   :integer         not null, primary key
#  project_id           :integer
#  default_sprint_weeks :integer         default(2)
#  created_at           :datetime
#  updated_at           :datetime
#

class Backlog < ActiveRecord::Base
  include StructuralItem::Model
  has_many :features, :as => :featurable, :dependent => :destroy
  has_many :sprints, :dependent => :destroy
  has_many :user_stories, :dependent => :destroy
  belongs_to :project
  
  holder :project
  
  def name
    "Backlog"
  end
  
  def current_sprint
    Sprint.current_sprint.find_by_backlog_id(id)
  end
  
  def latest_sprint
    sprints.order("start_date DESC").first
  end
  
  def future_sprints
    Sprint.future_sprints.where(:backlog_id => id)
  end
  
  def history_sprints
    Sprint.history_sprints.where(:backlog_id => id)
  end
  
end
