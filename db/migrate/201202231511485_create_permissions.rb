class CreatePermissions < ActiveRecord::Migration
  def up
    create_table :permissions do |t|
      t.references :user, :null => false
      t.references :organisation, :null => false
      t.references :profile,  :null => false
      t.integer :user_id,  :null => true
      t.timestamps
    end
  end

  def down
    drop_table :permissions
  end
end
