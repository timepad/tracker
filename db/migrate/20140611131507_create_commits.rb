class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.text :title
      t.string :user_github_login, :null => false
      t.integer :project_id, :null => false
      t.integer :changelog_id, :null => false
      t.datetime :github_created_at, :null => false
      t.string :github_html_url, :null => false

      t.timestamps
    end

    add_index :commits, :project_id
    add_index :commits, :github_html_url, :unique => true
  end
end
