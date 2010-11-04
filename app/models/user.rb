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
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  pwd_regex = /\A[\w\d\!-]{6,12}\z/i
  
  validates :email, :presence => true,
                    :format => {:with => email_regex},
                    :confirmation => true,
                    :uniqueness => {:case_sensitive => false}
  
  validates :password, :presence => true,
                       # :length => 6..12,
                       :format => {:with => pwd_regex },
                       :confirmation => true

  before_save :create_encrypted_password
  
  # class methods
  def self.authenticate(email, password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(password)
  end
  
  # instance methods
  def has_password?(submitted_password)
    self.encrypted_password == encrypt_password(submitted_password)
  end
  
  private
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
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
  
end
