class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def ajax_issues
    @issues = []

    Project.all.each do |project|
      @issues += Rails.configuration.github_client.list_issues(project.github_path)
    end
  end

  def ajax_projects
    @projects = []

    Project.all.each do |project|
      @projects << Rails.configuration.github_client.repository(project.github_path)
    end
  end

  def ajax_activities
    @notifications = []

    Project.all.each do |project|
      @notifications += Rails.configuration.github_client.repository_notifications(project.github_path, { :all => true })
    end
  end

  def requests
    @requests = Request.order('created_at desc').includes(:project).page params[:page]
  end
end
