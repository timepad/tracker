class Admin::StoryPointsController < AdminController
  def index
    @story_points = StoryPoint.fetch_with(params).order('github_closed_at DESC').page(params[:page])
  end

  def users
    @story_points = StoryPoint.fetch_with(params)
  end

  def sync
    pull_requests = Project.pull_requests

    StoryPoint.parse_pull_requests pull_requests

    @story_points = StoryPoint.order('github_closed_at DESC').page params[:page]
  end
end
