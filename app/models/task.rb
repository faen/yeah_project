# == Schema Information
# Schema version: 20110303114312
#
# Table name: tasks
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  description   :string(255)
#  fulfil_status :string(255)
#  taskable_id   :integer
#  taskable_type :string(255)
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Task < ActiveRecord::Base
  include AASM
  include StructuralItem::Model
  
  aasm_column :fulfil_status
  aasm_state :opened
  aasm_state :accepted
  aasm_state :progress
  aasm_state :finished
  aasm_state :approved
  aasm_initial_state :opened
  
  aasm_event :accept do
    transitions :to => :accepted, :from => [:opened]
  end
  
  aasm_event :set_to_work do
    transitions :to => :progress, :from => [:accepted, :opened]
  end
  
  aasm_event :finish do
    transitions :to => :finished, :from => [:progress]
  end
  
  aasm_event :approve do
    transitions :to => :approved, :from => [:finished]
  end
  
  
  belongs_to :status
  belongs_to :taskable, :polymorphic => true
  # belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
  belongs_to :user
  
  holder :taskable
  
  def fulfil_events
    [:accept, :set_to_work, :finish, :approve]
  end
end
