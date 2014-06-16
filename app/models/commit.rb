class Commit < ActiveRecord::Base
  belongs_to :project

  belongs_to :changelog

  class << self
    def parse_and_save_with commit_params, project, changelog
      Commit.find_or_create_by(:github_html_url => commit_params[:html_url]) do |commit|
        if commit_params[:author].present?
          commit.user_github_login = commit_params[:author][:login]
        else
          commit.user_github_login = commit_params[:commit][:author][:name]
        end

        commit.title = commit_params[:commit][:message]

        commit.github_created_at = commit_params[:commit][:committer][:date].to_datetime

        commit.project = Project.where(:github_path => project).first

        commit.changelog = changelog
      end
    end
  end
end
