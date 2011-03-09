# == Schema Information
# Schema version: 20110303114312
#
# Table name: features
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  description     :text
#  featurable_id   :integer
#  featurable_type :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class Feature < ActiveRecord::Base
  has_many :user_stories, :as => :tellable, :dependent => :destroy
  has_many :tasks, :as => :taskable, :dependent => :destroy
  belongs_to :featurable, :polymorphic => true
end
