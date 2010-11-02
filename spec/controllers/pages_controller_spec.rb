require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    it "should be successful" do
      get :home
      response.should be_success
    end
    
    it "should have the right title" do
      get :home
      response.should have_selector("title", :content => "Home")
    end
  end

  describe "GET 'features'" do
    it "should be successful" do
      get :features
      response.should be_success
    end
    
    it "should have the right title" do
      get :features
      response.should have_selector("title", :content => "Features")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get :about
      response.should be_success
    end
    
    it "should have the right title" do
      get :about
      response.should have_selector("title", :content => "About")
    end
  end
  
  describe "GET 'contact'" do
    it "should be successful" do
      get :contact
      response.should be_success
    end
    
    it "should have the right title" do
      get :contact
      response.should have_selector("title", :content => "Contact")
    end
  end
  
  describe "GET 'imprint'" do
    it "should be successful" do
      get :imprint
      response.should be_success
    end
    
    it "should have the right title" do
      get :imprint
      response.should have_selector("title", :content => "Imprint")
    end
  end

end
