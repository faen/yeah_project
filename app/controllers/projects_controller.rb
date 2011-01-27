class ProjectsController < ApplicationController
  
  # before_filter :authorized_user?, :only => [:index, :new, :create]
  before_filter :authorized_product_user?, :only => [:index, :new, :create]
  before_filter :authorized_project_member?, :only => [:show]
  before_filter :authorized_project_owner?, :only => [:edit, :update, :destroy]
  
  def index
    # @user = User.find_by_id(params[:user_id])
    @projects = @user.projects
  end
  
  def new
    @preselected_product = Product.find_by_id(params[:product_id])
    # @user = current_user
    @products = @user.products
    @project = @user.projects.build
  end
  
  def create
    # @user = current_user
    @products = @user.products
    @product = Product.find_by_id(params[:project][:product_id])
    @project = @user.projects.build params[:project] 
    if(@user.save)
      @members = @project.members
      redirect_to user_product_path(@user, @product)
    else
      render 'new'
    end
  end
  
  def edit
    @user = current_user
    @products = @user.products
    # @project = Project.find_by_id(params[:id])
    @products.delete @project.product
    @members = @project.members
  end
  
  def update
    @user = current_user
    @products = @user.products
    # @project = Project.find_by_id(params[:id])
    @products.delete @project.product
    @members = @project.members
    if(@project.update_attributes params[:project])
      
    else
      
    end
    render 'edit'
  end
  
  def destroy
    # @project = Project.find_by_id(params[:id])
    @project.destroy
    if(params[:user_id])
      redirect_to user_projects_path
    else
      redirect_to projects_path
    end
  end
  
  private 
    def authorized_product_user?
      return authorized_user? unless params[:user_id].blank?
      @product = Product.find_by_id(params[:product_id])
      @user = current_user
      authorized_member? @product
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