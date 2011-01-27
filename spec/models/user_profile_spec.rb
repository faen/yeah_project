require 'spec_helper'

describe UserProfile do
  
  before(:each) do
    @user = Factory(:user)
    @valid_attr = {:user => @user, :date_of_birth => Date.new(1998, 1, 1), :firstname => Faker::Name.first_name, :lastname => Faker::Name.last_name}
  end
  
  describe "invalid user profile" do
    it "should require a user" do
      @up = UserProfile.new(@valid_attr.merge :user => nil)
      @up.should_not be_valid
    end
    
    it "should require a date_of_birth" do
      @up = UserProfile.new(@valid_attr.merge :date_of_birth => nil)
      @up.should_not be_valid
    end
    
    it "should require a firstname" do
      @up = UserProfile.new(@valid_attr.merge :firstname => '')
      @up.should_not be_valid
    end
    
    it "should require a lastname" do
      @up = UserProfile.new(@valid_attr.merge :lastname => '')
      @up.should_not be_valid
    end
  end
  
  describe "valid user profile" do
    it "should be valid" do
      @up = UserProfile.new(@valid_attr)
      @up.should be_valid
    end
  end
end
