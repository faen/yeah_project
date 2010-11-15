require 'spec_helper'

describe User do
  before(:each) do
    # attributes to create a valid user
    @attr = {:email => "foo@bar.de", :password => "password"}
    @valid_emails = ["foo@bar.de", "FOO_BAZ@bar.de", "foo.baz@bar.de", "foo@bar.baz.de"]
    @invalid_emails = ["foobar.de", "foo@barde", "foo@bar,de", "foo@bar."]
    @invalid_passwords = ["fubar", "foo" * 5, "foobar?<>@"]
    @valid_passwords = ["foobar", "foo" * 4, "foobar_!-"]
  end
  describe "invalid User" do
    it "should require an email" do
      u = User.new @attr.merge :email => ""
      u.should_not be_valid
    end
    
    it "should reject invalid email formats" do
      @invalid_emails.each do |email|
        u = User.new(@attr.merge :email => email)
        u.should_not be_valid
      end
    end
    
    it "should reject duplicate emails" do
      u_1 = User.create!(@attr)
      u_2 = User.new(@attr)
      u_2.should_not be_valid
      u_3 = User.new(@attr.merge :email => @attr[:email].upcase)
      u_3.should_not be_valid
    end
    
    it "should require a password" do
      u = User.new(@attr.merge :password => "")
      u.should_not be_valid
    end
    
    it "should reject invalid password formats" do
      @invalid_passwords.each do |pwd|
        u = User.new(@attr.merge :password => pwd)
        u.should_not be_valid
      end
    end
  end
  
  describe "valid User" do
    it "should create a User with valid attributes" do
      u = User.new(@attr)
      u.should be_valid
    end
    
    it "should accept valid email formats" do
      @valid_emails.each do |email|
        u = User.new(@attr.merge :email => email)
        u.should be_valid
      end
    end
    
    it "should accept valid password formats" do
      @valid_passwords.each do |pwd|
        u = User.new(@attr.merge :password => pwd)
        u.should be_valid
      end
    end
  end

  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end
    it "should have an encrypted_password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should set an encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
    
    describe "has_password? method" do
      it "should be true if given password matches with the stored encrypted_password" do
        @user.has_password?(@attr[:password]).should be_true
      end
      
      it "should be false if given password does not match with the stored encrypted_password" do
        @user.has_password?("invalid").should be_false
      end
    end
  end
  
  describe "email acknowledgement" do
    before(:each) do
      @user = User.create!(@attr)
      @ack = @user.email_acknowledgement
    end
    
    it "should have an email_acknowledgement_attr" do
      @user.should respond_to(:email_acknowledgement)
    end
    
    it "should set an email_acknowledgement" do
      @ack.should_not be_blank
    end
    
    describe "email_acknowledgement" do
      it "email_ackowledgeable should be user" do
        @ack.email_acknowledgeable.should == @user
      end
      
      it "should have ack_status 'pending'" do
        @ack.ack_state.should == "pending"
      end
      
      it "should have attribute expire_date" do
        @ack.should respond_to :expire_date
      end
      
      it "should have an expire date 48 hrs greater than user's creation date" do
        @ack.expire_date.should == @user.created_at + 48 * 3600
      end
    end
  end

  describe "authenticate class method" do
    before(:each) do
      @user = User.create(@attr)
    end
    
    it "should have an email_acknowledged? attribute" do
      @user.should respond_to :email_acknowledged?
    end
    
    it "should return nil for an email mismatch" do
      u = User.authenticate("invalid@email.com", @attr[:password])
      u.should be_nil
    end
    
    it "should return nil for a password mismatch" do
      u = User.authenticate(@attr[:email], "invalid_password")
      u.should be_nil
    end
    
    it "should return nil for email_acknowledged? returning false" do
      u = User.authenticate(@attr[:email], @attr[:password])
      u.should be_nil
    end
    
    it "should return a user for an email/password match plus email_acknowledged? = true" do
      @user.email_acknowledgement.confirm!
      @user.save
      u = User.authenticate(@attr[:email], @attr[:password])
      u.should == @user
    end
  end
  
  describe "it should fail on invalid massassignments" do
    it "email_acknowledged = true as massassignement should fail" do
      @user = User.create!(@attr.merge(:email_acknowledgement => true))
      @user.email_acknowledged.should_not be_true
    end
  end

end
