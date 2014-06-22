class Admin::ChangelogsController < AdminController
  load_and_authorize_resource

  def index
    @changelogs = Changelog.fetch_with(params).order('github_created_at DESC').page(params[:page])
  end

  def show
    render :layout => false
  end

  def sync
    Changelog.parse_pull_requests_and_commits

    @changelogs = Changelog.order('github_created_at DESC').page params[:page]
  end
end
