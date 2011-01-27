class PlacesController < ApplicationController
  before_filter :authenticate_as_super_admin
  def index
    @countries = Country.all
  end
  
  def setup_countries
    Country.import
    @countries = Country.all
    render 'index'
  end
end