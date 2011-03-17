class SprintsController < ApplicationController
  def new
    @backlog = Backlog.find_by_id(params[:backlog_id])
    @sprint = @backlog.sprints.build
    latest_sprint = @backlog.latest_sprint
    puts "latest_sprint: #{latest_sprint.inspect}"
    start_date = latest_sprint ? latest_sprint.end_date + 1.day : Date.current
    end_date = start_date + @backlog.default_sprint_weeks.weeks
    @sprint.start_date = start_date
    @sprint.end_date = end_date
  end
  
  def create
    @backlog = Backlog.find_by_id(params[:backlog_id])
    @sprint = @backlog.sprints.create(params[:sprint])
    if(@backlog.save)
      redirect_to polymorphic_path([@backlog.holder.holder, @backlog.holder])
    else
      render 'edit'
    end
  end
  
  def edit
    
  end
  
  def update
    
  end
end