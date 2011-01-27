# == Schema Information
# Schema version: 20110119171126
#
# Table name: projects_members
#
#  user_id    :integer
#  project_id :integer
#  role_id    :integer
#

class ProjectsMember < ActiveRecord::Base
  
  def project
    Project.find(self.project_id)
  end
end
