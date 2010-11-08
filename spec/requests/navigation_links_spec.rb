require 'spec_helper'

describe "NavigationLinks" do
  
  it "should have the required links on the layout" do
    visit '/'
    click_link 'Features'
    response.should have_selector('title', :content => "Features")
    click_link 'About'
    response.should have_selector('title', :content => "About")
    click_link 'Sign in'
    response.should have_selector('title', :content => "Sign in")
  end
  
  it "It should have an 'home' page at '/'" do
    get '/'
    response.should be_success
    response.should have_selector('title', :content => "Home")
  end
  
  it "It should have a 'features' page at '/features'" do
    get '/features'
    response.should be_success
    response.should have_selector('title', :content => "Features")
  end
  
  it "It should have an 'about' page at '/about'" do
    get '/about'
    response.should be_success
    response.should have_selector('title', :content => "About")
  end
  
  it "It should have a 'contact' page at '/contact'" do
    get '/contact'
    response.should be_success
    response.should have_selector('title', :content => "Contact")
  end
  
  it "It should have an 'imprint' page at '/imprint'" do
    get '/imprint'
    response.should be_success
    response.should have_selector('title', :content => "Imprint")
  end
  
  it "It should have a 'signup' page at '/signup'" do
    get '/signup'
    response.should be_success
    response.should have_selector('title', :content => "Sign up")
  end
  
  it "It should have a 'signin' page at '/signin'" do
    get '/signin'
    response.should be_success
    response.should have_selector('title', :content => "Sign in")
  end
end
