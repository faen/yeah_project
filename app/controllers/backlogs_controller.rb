class BacklogsController < ApplicationController
 def show
   @backlog = Backlog.find_by_id(params[:id])
 end
 
 def edit
   @backlog = Backlog.find_by_id(params[:id])
 end
 
 def update
   @backlog = Backlog.find_by_id(params[:id])
   if(@backlog.update_attributes params[:backlog])
     redirect_to polymorphic_path([@backlog.project, @backlog])
   else
     render 'edit'
   end
 end
end