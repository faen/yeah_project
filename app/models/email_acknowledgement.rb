# == Schema Information
# Schema version: 20110119171126
#
# Table name: email_acknowledgements
#
#  id                         :integer         not null, primary key
#  token                      :string(255)
#  expire_date                :datetime
#  ack_state                  :string(255)
#  email_acknowledgeable_id   :integer
#  email_acknowledgeable_type :string(255)
#  created_at                 :datetime
#  updated_at                 :datetime
#

class EmailAcknowledgement < ActiveRecord::Base
  include AASM
  
  aasm_column :ack_state
  aasm_state :pending, :enter => :on_pending
  aasm_state :acknowledged
  aasm_state :expired
  aasm_initial_state :pending
  
  aasm_event :confirm do
    transitions :to => :acknowledged, :from => [:pending]
  end
  
  aasm_event :timeout do
    transitions :to => :expired, :from => [:pending]
  end
  
  aasm_event :reset do
    transitions :to => :pending, :from => [:acknowledged, :expired]
  end
  
  
  
  attr_accessible :email_acknowledgeable, :email, :expiration_hours
  attr_accessor :expiration_hours, :email
  
  belongs_to :email_acknowledgeable, :polymorphic => true
  
  
  validates :expiration_hours, :presence => true,
                             :numericality => true,
                             :if => :should_validate_volatile_attributes?

  validates :email, :presence => true,
                    :if => :should_validate_volatile_attributes?
  
  validates :email_acknowledgeable, :presence => true
  
  def status
    ack_state
  end
  
  
  private
    def should_validate_volatile_attributes?
      return true if self.new_record? || self.ack_state == :pending
    end
    
    def on_pending
      create_expiration_date
      create_token_from_email_and_time
    end
    
    def create_expiration_date
      add_hours = expiration_hours ||= 48
      self.expire_date = Time.now + add_hours.hours
    end
    
    def create_token_from_email_and_time
      self.token = secure_hash("#{self.email}--#{Time.now.utc}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
