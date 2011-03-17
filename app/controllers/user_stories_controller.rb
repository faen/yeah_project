class UserStoriesController < ApplicationController
  
  def index
    @user_stories = UserStory.all
  end
  
  def new
    @backlog = Backlog.find_by_id(params[:backlog_id])
    @user_story = UserStory.new
  end
  
  def create
    @backlog = Backlog.find_by_id(params[:backlog_id])
    @user_story = @backlog.user_stories.build(params[:user_story])
    if(@backlog.save)
      redirect_to polymorphic_path([@backlog, @user_story])
    else
      render 'edit'
    end
  end
  
  def show
    @taskable = @user_story = UserStory.find_by_id(params[:id])
    @tasks = @user_story.tasks
    @acceptance_tests = @user_story.acceptance_tests
  end
  
  def edit
    @user_story = UserStory.find_by_id(params[:id])
    @backlog = @user_story.backlog
    @acceptance_tests = @user_story.acceptance_tests
  end
  
  def update
    @user_story = UserStory.find_by_id(params[:id])
    if(@user_story.update_attributes params[:user_story])
      redirect_to polymorphic_path([@user_story.backlog, @user_story])
    else
      render 'edit'
    end
  end
  
  def destroy
    @user_story = UserStory.find_by_id(params[:id])
    @backlog = @user_story.backlog
    UserStory.find_by_id(params[:id]).destroy
    redirect_to polymorphic_path(@backlog.holder, @backlog)
  end
  
end