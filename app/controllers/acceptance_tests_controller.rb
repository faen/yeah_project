class AcceptanceTestsController < ApplicationController
  def new
    @user_story = UserStory.find_by_id(params[:user_story_id])
    @acceptance_test = @user_story.acceptance_tests.build
  end
  
  def create
    @user_story = UserStory.find_by_id(params[:user_story_id])
    @acceptance_test = @user_story.acceptance_tests.build(params[:acceptance_test])
    if(@user_story.save)
      redirect_to polymorphic_path([@user_story.holder, @user_story])
    else
      render 'edit'
    end
  end
  
  def edit
    @acceptance_test = AcceptanceTest.find_by_id(params[:id])
    @user_story = @acceptance_test.user_story
  end
  
  def update
    @acceptance_test = AcceptanceTest.find_by_id(params[:id])
    @user_story = @acceptance_test.user_story
    if(@acceptance_test.update_attributes(params[:acceptance_test]))
      redirect_to polymorphic_path([@user_story.holder, @user_story])
    else
      render 'edit'
    end
  end
  
  def destroy
    @acceptance_test = AcceptanceTest.find_by_id(params[:id])
    @user_story = @acceptance_test.user_story
    @acceptance_test.destroy
    redirect_to polymorphic_path([@user_story.holder, @user_story])
  end
end