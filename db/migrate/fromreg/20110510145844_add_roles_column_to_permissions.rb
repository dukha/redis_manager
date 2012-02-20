class AddRolesColumnToPermissions < ActiveRecord::Migration
  def self.up
    add_column :permissions, :roles, :text
    # text type is needed for rails to serialise into a yaml string
    # what is the size of thext?
  end

  def self.down
    remove_column :permissions, :roles
  end
end
