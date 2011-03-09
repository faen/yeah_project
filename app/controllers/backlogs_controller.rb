class BacklogsController < ApplicationController
 def show
   @backlog = Backlog.find_by_id(params[:id])
 end
end