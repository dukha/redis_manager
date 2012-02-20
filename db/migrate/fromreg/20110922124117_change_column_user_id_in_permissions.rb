class ChangeColumnUserIdInPermissions < ActiveRecord::Migration
  def self.up
    change_column :permissions, :user_id, :integer, :null => true
  end

  def self.down
    change_column :permissions, :user_id, :integer, :null => false
  end
end
