class ChangeColumnCurrentPermissionIdInUser < ActiveRecord::Migration
  def self.up
    # each user remebers always it's current permission even while signed out (remeber users selection across sessions).
    change_column :users, :current_permission_id, :integer,  :null=>true
  end

  def self.down
    change_column :users, :current_permission_id, :integer
  end
end
