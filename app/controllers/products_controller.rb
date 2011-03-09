class ProductsController < ApplicationController
  # before_filter :authorized_user?, :only => [:index, :new, :create]
  before_filter :authorized_realm_user?, :only => [:index, :new, :create]
  before_filter :authorized_product_member?, :only => [:show]
  before_filter :authorized_product_owner?, :only => [:edit, :update, :destroy]
  
  def index
    if @realm
      @products = @realm.products
    else
      @products = @user.products
    end
  end
  
  def new
    @realms = @user.realms
    @preselected_realm = Realm.find_by_id(params[:realm_id])
    @product = @user.products.build
  end
  
  def create
    @realms = @user.realms
    @realm = Realm.find_by_id(params[:product][:realm_id])
    @product = @realm.products.build params[:product]
    @user.products << @product
    if(@realm.save)
      redirect_to realm_product_path(@realm, @product)
    else
      render 'new'
    end
  end
  
  def show
    @product = Product.find_by_id(params[:id])
    @projects = @product.projects
  end
  
  def edit
    @user = current_user
    @realms = @user.realms
  end
  
  def update
    @user = current_user
    @realms = @user.realms
    # @realm = Realm.find_by_id(params[:id]) --> set by before_filter
    if(@product.update_attributes params[:product])
      
    else
      
    end
    render 'edit'
  end
  
  def destroy
    @product.destroy
    redirect_to user_products_path(current_user)
  end
  
private 
  def authorized_realm_user?
    return authorized_user? unless params[:user_id].blank?
    @realm = Realm.find_by_id(params[:realm_id])
    @user = current_user
    authorized_member? @realm
  end
  
  def authorized_product_member?
    @product = Product.find_by_id(params[:id])
    authorized_member? @product
  end
  
  def authorized_product_owner?
    @product = Product.find_by_id(params[:id])
    authorized_owner? @product
  end
end