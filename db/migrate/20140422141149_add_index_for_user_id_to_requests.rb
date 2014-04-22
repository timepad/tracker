class AddIndexForUserIdToRequests < ActiveRecord::Migration
  def change
    add_index :requests, :user_id
  end
end
