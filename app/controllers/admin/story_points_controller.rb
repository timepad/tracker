class Admin::StoryPointsController < AdminController
  load_and_authorize_resource :param_method => :permitted_params

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

  def update_to_github
    @updated = @story_point.update_attributes(permitted_params)

    if @updated
      Rails.configuration.github_client.
        update_pull_request @story_point.project.github_path, @story_point.github_id,
                            :body => @story_point.github_body
    end
  end

  private

  def permitted_params
    params.require(:story_point).permit(:title, :story_point_type, :story_point_size, :story_point_from)
  end
end
