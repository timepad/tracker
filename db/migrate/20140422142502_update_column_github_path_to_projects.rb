class UpdateColumnGithubPathToProjects < ActiveRecord::Migration
  def up
    change_column :projects, :github_path, :string, :null => false, :default => '', :unique => true

    add_index :projects, :github_path, :unique => true
  end

  def down
    change_column :projects, :github_path, :string

    remove_index :projects, :github_path
  end
end
