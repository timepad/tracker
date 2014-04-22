class AddGithubIssueIdToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :github_issue_id, :integer
  end
end
