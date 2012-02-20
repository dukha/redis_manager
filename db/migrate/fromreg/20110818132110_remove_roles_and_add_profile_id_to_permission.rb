class RemoveRolesAndAddProfileIdToPermission < ActiveRecord::Migration
  def self.up
    remove_column :permissions, :roles
    add_column :permissions, :profile_id, :integer, :null => false
  end

  def self.down
  end
end
