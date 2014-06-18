class AddGithubIdToStoryPoints < ActiveRecord::Migration
  def change
    add_column :story_points, :github_id, :integer
  end
end
