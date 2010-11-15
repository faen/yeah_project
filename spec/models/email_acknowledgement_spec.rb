require 'spec_helper'

describe EmailAcknowledgement do
  before(:each) do
    @user = User.create! valid_user_attributes
    @ack = @user.email_acknowledgement
    @ea_attr = {:email_acknowledgeable => @user, :email => @user.email, :expiration_hours => 48}
  end
  describe "invalid Email Acknowledgement" do
    
    it "should require email_acknowledgeable" do
      ea = EmailAcknowledgement.new @ea_attr.merge(:email_acknowledgeable => nil)
      ea.should_not be_valid
    end
    
    it "should require email" do
      ea = EmailAcknowledgement.new @ea_attr.merge(:email => "")
      ea.should_not be_valid
    end
    
    it "should require expiration_hours" do
      ea = EmailAcknowledgement.new @ea_attr.merge(:expiration_hours => nil)
      ea.should_not be_valid
    end
    
    it "should reject an invalid Email"
    
    it "should reject an invalid EmailAcknowledgeable entity"
  end
  
  describe "valid Email Acknowledgement" do
    
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
    
    it "should have a token" do
      @ack.should respond_to :token
    end
    
    describe "token" do
      it "should not be blank" do
        @ack.token.should_not be_blank
      end
    end
  end
end
