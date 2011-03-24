class ProductsController < ApplicationController
  # before_filter :authorized_user?, :only => [:index, :new, :create]
  before_filter :authorized_realm_user?, :only => [:index, :new, :create]
  before_filter :authorized_product_member?, :only => [:show]
  before_filter :authorized_product_owner?, :only => [:edit, :update, :destroy]
  
  def index
    @products = @user.products
    @assigned_products = @user.assigned_products
  end
  
  def new
    @realms = @user.realms + @user.assigned_realms
    @preselected_realm = Realm.find_by_id(params[:realm_id])
    @product = @user.products.build
    @product_members = @product.assigned_users
  end
  
  def create
    @realms = @user.realms + @user.assigned_realms
    @realm = Realm.find_by_id(params[:product][:realm_id])
    @product = @user.products.build(params[:product])
    if(@user.save)
      redirect_to realm_product_path(@realm, @product)
    else
      render 'new'
    end
  end
  
  def show
    @product = Product.find_by_id(params[:id])
    @assigned_users = @product.crowd
    @projects = @product.projects
  end
  
  def edit
    # @product.assignments.build if !@product.assignments
    @user = current_user
    @realms = @user.realms + @user.assigned_realms
    @product_members = @product.assigned_users
  end
  
  def update
    params[:product][:assigned_users] ||= []
    @user = current_user
    if(@product.update_attributes params[:product])
      redirect_to edit_product_path(@product)
    else
      @realms = @user.realms + @user.assigned_realms
      @product_members = @product.assigned_users
      render 'edit'
    end
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