class Project < ActiveRecord::Base
  validates :github_url, :presence => true, :uniqueness => true
end
