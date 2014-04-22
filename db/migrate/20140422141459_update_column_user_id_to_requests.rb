class UpdateColumnUserIdToRequests < ActiveRecord::Migration
  def up
    change_column :requests, :user_id, :integer, :null => false, :default => 0
  end

  def down
    change_column :requests, :user_id, :integer
  end
end
