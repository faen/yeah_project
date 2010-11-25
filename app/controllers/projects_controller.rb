class ProjectsController < ApplicationController
  def index
    @user = User.find_by_id(params[:user_id])
    if(@user.nil?)
      @projects = Project.all
    else
      @projects = @user.projects
    end
  end
  
  def new
    @project = current_user.projects.build
  end
  
  def create
    @user = current_user
    @project = current_user.projects.build params[:project] 
    
    if(@user.save)
      render 'edit'
    else
      render 'new'
    end
  end
  
  def edit
    @project = Project.find_by_id(params[:id])
  end
  
  def update
    @project = Project.find_by_id(params[:id])
    if(@project.update_attributes params[:project])
      
    else
      
    end
    render 'edit'
  end
  
  def destroy
    @project = Project.find_by_id(params[:id])
    @project.destroy
    if(params[:user_id])
      redirect_to user_projects_path
    else
      redirect_to projects_path
    end
  end
end