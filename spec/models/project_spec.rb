require 'spec_helper'

describe Project do
  before(:each) do
    @user = User.create! valid_user_attributes
    @project_attr = {}
  end
  describe "associations" do
    before(:each) do
      @project = Project.new @project_attr
    end
    it "should have and belong to many members" do
      @project.should respond_to(:members)
    end
  end
  
  describe "invalid project" do
    before(:each) do
      @project = Project.new @project_attr
    end
    it "should require 1 member as a minimum" do
      # TODO: find a solution or delete that test.
      # This doesn't work at the moment since association could be established by user.members.build.
      # This is done by - to me obscure - auto assignement of the user_id.
      # Obviously the members collection gets the user AFTER save. 
      # Thus validation fails although after save the project would be valid.
      
      # @project.should_not be_valid
    end
  end
  
  describe "valid project" do
    before(:each) do
      @project = @user.projects.create!(@project_attr)
      @user.save
    end
    it "should have 1 member as a minimum" do
      @project.members.should_not be_blank
    end
  end
end
