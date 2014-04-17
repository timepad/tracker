class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, :null => false, :default => ''
    add_column :users, :skype, :string
    add_column :users, :vk, :string
    add_column :users, :twitter, :string
    add_column :users, :facebook, :string
  end
end
