class AddProjectIdToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :project_id, :integer, :null => false, :default => 0

    add_index :requests, :project_id
  end
end
