# == Schema Information
# Schema version: 20110315215540
#
# Table name: sprints
#
#  id         :integer         not null, primary key
#  backlog_id :integer
#  start_date :date
#  end_date   :date
#  created_at :datetime
#  updated_at :datetime
#

class Sprint < ActiveRecord::Base
  include StructuralItem::Model
  
  belongs_to :backlog
  has_many :user_stories
  
  holder :backlog
  
  before_create :create_sprint_nr 
  
  scope :current_sprint, lambda{
    time_now = Time.now
    where( 'start_date <= :date_now AND end_date >= :date_now', {:date_now => Date.civil(time_now.year, time_now.month, time_now.day)} )
  }
  
  scope :future_sprints, lambda{
    time_now = Time.now
    where( 'start_date > :date_now', {:date_now => Date.civil(time_now.year, time_now.month, time_now.day)} )
  }
  
  scope :history_sprints, lambda{
    time_now = Time.now
    where( 'end_date < :date_now', {:date_now => Date.civil(time_now.year, time_now.month, time_now.day)} )
  }
  
  def name
    "#{start_date} - #{end_date}"
  end
  
  def is_current?
    d = Date.current
    start_date <= d && end_date >= d
  end
  
  def create_sprint_nr
    count = backlog.sprints.count + 1
    puts "create_sprint_nr: #{count}"
    self.sprint_nr = count
    puts "created? #{self.sprint_nr}"
  end
  
end
