# == Schema Information
# Schema version: 20101104075609
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  email              :string(255)
#  salt               :string(255)
#  encrypted_password :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

require 'digest'

class User < ActiveRecord::Base
  attr_accessible :email, :email_confirmation, :password, :password_confirmation
  attr_accessor :password
  
  has_one :email_acknowledgement, :as => :email_acknowledgeable
  has_and_belongs_to_many :projects, :join_table => :projects_members
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  pwd_regex = /\A[\w\d\!-]{6,12}\z/i
  
  validates :email, :presence => true,
                    :format => {:with => email_regex},
                    :confirmation => true,
                    :uniqueness => {:case_sensitive => false}
  
  validates :password, :presence => true,
                       :format => {:with => pwd_regex },
                       :confirmation => true,
                       :if => :should_validate_volatile_attributes?

  before_create :create_email_acknowledgement
  before_save :create_encrypted_password, :if => lambda { !self.password.nil? }
  
  # class methods
  def self.authenticate(email, password)
    user = find_by_email(email)
    return nil if user.nil?
    return nil if !user.email_acknowledged?
    return user if user.has_password?(password)
  end
  
  def self.authenticate_from_session(session_user_id, session_user_salt)
    user = find_by_id(session_user_id)
    (user && user.salt == session_user_salt) ? user : nil
  end
  
  # instance methods
  def has_password?(submitted_password)
    self.encrypted_password == encrypt_password(submitted_password)
  end
  
  def email_acknowledged?
    self.email_acknowledgement.acknowledged?
  end
  
  private
    def should_validate_volatile_attributes?
      return true if self.new_record?
    end
    
    def create_encrypted_password
      self.salt = create_salt if self.new_record?
      self.encrypted_password = encrypt_password(self.password)
    end
    
    def encrypt_password(submitted_password)
      secure_hash("#{self.salt}--#{submitted_password}")
    end
    
    def create_salt
      secure_hash("#{Time.now.utc}--#{self.password}")
    end
    
    def create_email_acknowledgement
        self.email_acknowledgement = EmailAcknowledgement.new :email_acknowledgeable => self,
                                                              :email => self.email,
                                                              :expiration_hours => 48
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
  
end
