require 'spec_helper'

describe UsersController do
  render_views
  
  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector('title', :content => "Sign up")
    end
  end

  describe "GET 'show" do
    before(:each) do
      @user = Factory(:user)
      controller.sign_in(@user)
    end
    
    it "should be successfull" do
      get :show, :id => @user
      response.should be_success
    end
    
    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
  end
  
  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = {:email => "", :email_confirmation => "",
                 :password => "", :password_confirmation => ""}
      end
      
      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end
      
      it "should render the user/new page" do
        post :create, :user => @attr
        response.should render_template('new')
      end
      
      it "should have the right title" do
        post :create, :user => @attr
        response.should have_selector('title', :content => "Sign up")
      end
      
      it "should display error messages" do 
        post :create, :user => @attr
        response.should have_selector('.error_explanation')
      end
    end
    
    describe "success" do
      it "should be successful" do
        post :create, :user => valid_user_attributes
        response.should be_success
      end
      
      it "should render confirmation page" do
        post :create, :user => valid_user_attributes
        response.should have_selector('h1', :content => "Your signup confirmation") 
      end
    end
  end
  
  describe "PUT 'update'" do
    before(:each) do
      @user = Factory(:user)
    end
    
    describe "Access control" do
      it "should deny access" do
        put :update, :id => @user, :user => {}
        response.should be_redirect
      end
      
      it "should allow access" do
        controller.sign_in(@user)
        put :update, :id => @user, :user => {}
        response.should be_success
      end
    end
    
    describe "update the user's email address" do
      before(:each) do
        @user.email_acknowledgement.confirm!
        controller.sign_in(@user)
      end
      
      it "should be successful" do
        
      end
      
      it "should signout the user" do
        controller.signed_in?.should be_true
        put :update, :id => @user, :user => {:email => "fabian.englaender@enterat.de"}
        response.should redirect_to(root_path)
        controller.signed_in?.should be_false
      end
    end
  end
  
  describe "Delete 'destroy'" do
    
  end
end
