# == Schema Information
# Schema version: 20110315215540
#
# Table name: user_stories
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  role         :string(255)
#  goal         :string(255)
#  benefit      :string(255)
#  story_points :integer
#  priority     :integer
#  feature_id   :integer
#  backlog_id   :integer
#  sprint_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class UserStory < ActiveRecord::Base
  include StructuralItem::Model
  belongs_to :backlog
  belongs_to :sprint
  has_many :tasks, :as => :taskable, :dependent => :destroy
  has_many :acceptance_tests, :dependent => :destroy
  
  holder :backlog
  
  def story
    "As a #{role} i want #{goal} so that #{benefit}"
  end
  
  def story_markup
    s = "<span>As a <strong>#{role}</strong> i want <strong>#{goal}</strong> so that <strong>#{benefit}</strong>"
    s.html_safe
  end
  
  def tasks_count_markup
    finished = tasks.map{|t| t if t.fulfil_status == :finshed || t.fulfil_status == :approved }.count
    open = tasks.count - finished
    tc = "<span style='color:#009036;'>#{finished}</span> | <span>#{open}</span>"
    tc.html_safe
  end
  
  def tests_count_markup
    succeeded = acceptance_tests.map{|t| t if t.fulfilled}.compact.count
    open = acceptance_tests.map{|t| t if t.fulfilled.blank?}.compact.count
    failed = acceptance_tests.map{|t| t if !t.fulfilled}.compact.count
    failed = failed - open
    tc = "<span style='color:#009036;'>#{succeeded}</span> | <span style='color:#e2001a;'>#{failed}</span> | <span>#{open}</span>"
    tc.html_safe
  end
  
  def on_sprint?
    self.sprint ? "yes" : "no"
  end
end
