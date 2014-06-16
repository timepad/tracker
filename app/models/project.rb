class Project < ActiveRecord::Base
  validates :github_path, :presence => true, :uniqueness => true

  has_many :requests, :dependent => :destroy

  has_many :story_points, :dependent => :destroy

  has_many :changelogs

  class << self
    def pull_requests
      pull_requests = []

      Project.all.each do |project|
        p = 1

        pull_requests_list = Rails.configuration.github_client.
          pull_requests(project.github_path, { :state => 'closed', :page => p })

        while pull_requests_list.present?
          pull_requests += pull_requests_list

          p += 1

          pull_requests_list = Rails.configuration.github_client.
            pull_requests(project.github_path, { :state => 'closed', :page => p })
        end
      end

      pull_requests
    end
  end
end
