require 'spec_helper'

describe Product do
  before(:each) do
    @user = Factory(:user)
    @realm = Factory(:realm)
    @valid_attr = { name: Faker::Name.name, user: @user, realm: @realm}
  end
  describe "invalid product" do
    
    it "should require a name" do
      r = Product.new(@valid_attr.merge :name => '')
      r.should_not be_valid
    end
    
    it "should require an user" do
      r = Product.new(@valid_attr.merge :user => nil)
      r.should_not be_valid
    end
    
    it "should require a realm" do
      r = Product.new(@valid_attr.merge :realm => nil)
      r.should_not be_valid
    end
  end
  
  describe "valid product" do
    it "should be valid" do
      r = Product.new(@valid_attr)
      r.should be_valid
    end
  end
end
