class ProjectsController < ApplicationController
  
  # before_filter :authorized_user?, :only => [:index, :new, :create]
  # before_filter :authorized_product_user?, :only => [:index, :new, :create]
  # before_filter :authorized_project_member?, :only => [:show]
  # before_filter :authorized_project_owner?, :only => [:edit, :update, :destroy]
  
  def index
    @user = current_user
    @projects = @user.projects
    @assigned_projects = @user.assigned_projects
  end
  
  def new
    @user = current_user
    @preselected_product = Product.find_by_id(params[:product_id])
    @products = @user.products
    @project = @user.projects.build
    @project_members = @project.assigned_users
  end
  
  def create
    @user = current_user
    @products = @user.products
    @product = Product.find_by_id(params[:project][:product_id])
    @project = @user.projects.build params[:project] 
    if(current_user.save)
      redirect_to product_project_path(@product, @project)
    else
      render 'new'
    end
  end
  
  def show
    @project = Project.find_by_id(params[:id])
    @project_members = @project.assigned_users
    @taskable = @project
    @backlog = @project.backlog
    @sprints = @project.sprints
    @current_sprint = @backlog.current_sprint
    @future_sprints = @backlog.future_sprints
    @history_sprints = @backlog.history_sprints
    @user = current_user
    @tasks = @project.tasks
    @user_stories = @project.backlog.user_stories
    
    @assigned_users = @project.crowd
  end
  
  def edit
    @project = Project.find_by_id(params[:id])
    @project_members = @project.crowd
    @user = current_user
    @products = @user.products
  end
  
  def update
    params[:project][:assigned_users] ||= []
    @project = Project.find_by_id(params[:id])
    if(@project.update_attributes params[:project])
      redirect_to edit_project_path(@project)
    else
      @project_members = @project.crowd
      @user = current_user
      @products = @user.products
      render 'edit'
    end
  end
  
  def destroy
    @project = Project.find_by_id(params[:id])
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