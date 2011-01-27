require 'spec_helper'

describe Realm do
  before(:each) do
    @user = Factory(:user)
    @valid_attr = { name: Faker::Name.name, user: @user}
  end
  describe "invalid realm" do
    before(:each) do
      
    end
    
    it "should require a name" do
      r = Realm.new(@valid_attr.merge :name => '')
      r.should_not be_valid
    end
    
    it "should require an user_id" do
      r = Realm.new(@valid_attr.merge :user => nil)
      r.should_not be_valid
    end
  end
  
  describe "valid realm" do
    it "should be valid" do
      r = Realm.new(@valid_attr)
      r.should be_valid
    end
  end
end
