class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def ajax_issues
    @issues = []

    Project.all.each do |project|
      @issues += github_client.list_issues(project.github_url)
    end

    render :layout => false
  end

  def ajax_projects
    @projects = []

    Project.all.each do |project|
      @projects << github_client.repository(project.github_url)
    end

    render :layout => false
  end

  def ajax_activities
    @notifications = []

    Project.all.each do |project|
      @notifications += github_client.repository_notifications(project.github_url)
    end

    render :layout => false
  end

  def requests
    @requests = Request.order('created_at desc').page params[:page]
  end
end
