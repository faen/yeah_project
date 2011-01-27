require 'spec_helper'

describe PlacesController do
  render_views
  
  describe "Access control" do
    before(:each) do
      @user = Factory(:user)
    end
    
    it "should deny access" do
      get :index
      response.should be_redirect
    end
  end
end