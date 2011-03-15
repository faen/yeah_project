class TasksController < ApplicationController
  include StructuralItem::Controller

  before_filter lambda{@taskable = get_polymorhic_parent_from_params}
  
  def index
    
  end
  
  def new
    @members = User.all
    @task = Task.new
    puts("members: #{@members.inspect}")
  end
  
  def create
    @task = @taskable.tasks.build(params[:task])
    if(@taskable.save)
      redirect_to polymorphic_path([@taskable.holder, @taskable])
    else
      render 'edit'
    end
  end
  
  def show
    @task = Task.find_by_id(params[:id])
  end
  
  def edit
    @members = User.all
    @task = Task.find_by_id(params[:id])
  end
  
  def update
    @task = Task.find_by_id(params[:id])
    if(@task.update_attributes params[:task])
      redirect_to polymorphic_path([@taskable.holder, @taskable])
    else
      render 'edit'
    end
  end
  
  def destroy
    Task.find_by_id(params[:id]).destroy
    redirect_to polymorphic_path([@taskable.holder, @taskable])
  end
  
private
  def find_taskable
    params.each do |key, value|
      if key =~ /(.+)_id$/
        @taskable = $1.classify.constantize.find_by_id(value)
        taskable_class_name = @taskable.class.name.underscore
        taskable_path_token = "#{taskable_class_name}_path"
        target = @taskable
        parent = current_user
        if(taskable_class_name == 'user_story')
          parent = @taskable.tellable
        end
        taskable_path_token = "#{parent.class.name.underscore}_#{taskable_path_token}"
        @redirect_to_parent_scope_path = send(taskable_path_token, parent, target)
        return
      end
    end
    nil
  end
end