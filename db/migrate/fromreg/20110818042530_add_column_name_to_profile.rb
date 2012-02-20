class AddColumnNameToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :name, :string, :null => false, :unique => true
  end

  def self.down
    remove_column :profiles, :name
  end
end
