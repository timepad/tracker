class AddChangelogIdToStoryPoints < ActiveRecord::Migration
  def change
    add_column :story_points, :changelog_id, :integer

    add_index :story_points, :changelog_id
  end
end
