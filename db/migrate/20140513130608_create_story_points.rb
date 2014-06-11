class CreateStoryPoints < ActiveRecord::Migration
  def change
    create_table :story_points do |t|
      t.text :title
      t.string :user_github_login, :null => false
      t.string :user_github_avatar_url
      t.integer :user_id
      t.string :story_point_size
      t.datetime :github_closed_at
      t.datetime :github_merged_at
      t.string :story_point_type
      t.string :github_html_url, :null => false
      t.integer :project_id

      t.timestamps
    end

    add_index :story_points, :project_id
  end
end
