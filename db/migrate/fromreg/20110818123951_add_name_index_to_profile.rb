class AddNameIndexToProfile < ActiveRecord::Migration
  def self.up
    change_column :profiles, :name, :string, :null => false
    add_index :profiles, :name,                :unique => true
  end

  def self.down
  end
end
