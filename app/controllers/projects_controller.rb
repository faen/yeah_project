class ProjectsController < ApplicationController
  
  # before_filter :authorized_user?, :only => [:index, :new, :create]
  before_filter :authorized_product_user?, :only => [:index, :new, :create]
  before_filter :authorized_project_member?, :only => [:show]
  before_filter :authorized_project_owner?, :only => [:edit, :update, :destroy]
  
  def index
    @projects = @user.projects
  end
  
  def new
    @preselected_product = Product.find_by_id(params[:product_id])
    @products = @user.products
    @project = @user.projects.build
  end
  
  def create
    @products = @user.products
    @product = Product.find_by_id(params[:project][:product_id])
    @project = @user.projects.build params[:project] 
    if(@user.save)
      @members = @project.members
      redirect_to product_project_path(@product, @project)
    else
      render 'new'
    end
  end
  
  def show
    @taskable = @project
    @backlog = @project.backlog
    @sprints = @project.sprints
    @current_sprint = @backlog.current_sprint
    @future_sprints = @backlog.future_sprints
    @history_sprints = @backlog.history_sprints
    @user = current_user
    @tasks = @project.tasks
    @user_stories = @project.backlog.user_stories
  end
  
  def edit
    @user = current_user
    @products = @user.products
    # @products.delete @project.product
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
    @product = @project.product
    @realm = @product.realm
    @project.destroy
    redirect_to realm_product_path(@realm, @product)
  end
  
  private 
    def authorized_product_user?
      return authorized_user? unless params[:user_id].blank?
      @product = Product.find_by_id(params[:product_id])
      @user = current_user
      authorized_member? @product
    end
    
    def authorized_project_member?
      @project = Project.find_by_id(params[:id])
      authorized_member? @project
    end

    def authorized_project_owner?
      @project = Project.find_by_id(params[:id])
      authorized_owner? @project
    end
end