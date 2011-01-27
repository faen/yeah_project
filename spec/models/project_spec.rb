require 'spec_helper'

describe Project do
  before(:each) do
    @project_owner = Factory(:user)
    @product = Factory(:product)
    @valid_attr = { name: Faker::Name.name, user: @project_owner, product: @product}
  end
  describe "associations" do
    before(:each) do
      @project = Project.new @valid_attr
    end
    
    it "should belong to one user" do
      @project.should respond_to(:user)
    end
    
    it "should have and belong to many members" do
      @project.should respond_to(:members)
    end
    
    it "should belong to one product" do
      @project.should respond_to(:product)
    end
    
    it "should belong to one realm" do
      @project.should respond_to(:realm)
    end
  end
  
  describe "invalid project" do
    
    it "should require a name" do
      @project = Project.new(@valid_attr.merge :name => '')
      @project.should_not be_valid
    end
    
    it "should require a user" do
      @project = Project.new(@valid_attr.merge :user => nil)
      @project.should_not be_valid
    end
    
    it "should require a product" do
      @project = Project.new(@valid_attr.merge :product => nil)
      @project.should_not be_valid
    end
    
  end
  
  describe "valid project" do
    
    it "should be valid" do
      @project = Project.new(@valid_attr)
      @project.should be_valid
    end
    
    it "should have 1 member as a minimum" do
      @project = @project_owner.projects.create(@valid_attr)
      @project.members.should_not be_blank
      @project.members.size.should == 1
    end
  end
end
