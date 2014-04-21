class ChangeGithubUrlName < ActiveRecord::Migration
  def change
    rename_column :projects, :github_url, :github_path
  end
end
