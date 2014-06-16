class Admin::ChangelogsController < AdminController
  def index
    @changelogs = Changelog.fetch_with(params).order('github_created_at DESC').page(params[:page])
  end

  def sync
    Changelog.parse_pull_requests_and_commits

    @changelogs = Changelog.order('github_created_at DESC').page params[:page]
  end
end
