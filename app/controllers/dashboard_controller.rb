class DashboardController < ApplicationController
  def show
    @notifications = github_client.notifications
  end

  def projects
    @projects = github_client.org_repos('timepad')
  end

  def issues
    @issues = github_client.list_issues
  end
end
