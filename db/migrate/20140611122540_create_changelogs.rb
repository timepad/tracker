class CreateChangelogs < ActiveRecord::Migration
  def change
    create_table :changelogs do |t|
      t.text :title
      t.integer :project_id
      t.datetime :github_created_at

      t.timestamps
    end

    add_index :changelogs, :project_id
  end
end
