class AddFromToStoryPoints < ActiveRecord::Migration
  def change
    add_column :story_points, :story_point_from, :string
  end
end
