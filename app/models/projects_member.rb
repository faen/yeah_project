class ProjectsMember < ActiveRecord::Base
  
  def project
    Project.find(self.project_id)
  end
end