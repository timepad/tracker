class Project < ActiveRecord::Base
  validates :github_path, :presence => true, :uniqueness => true
end
