class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :github_url

      t.timestamps
    end
  end
end
