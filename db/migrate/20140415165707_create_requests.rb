class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :title, :null => false, :default => ''
      t.text :content

      t.timestamps
    end
  end
end
