class AlterUsersEmailNull < ActiveRecord::Migration
  def up
    # Device 2 seems to have a problem if both email and username are not null
    # Try to wrok around this
    change_table :users do |t|
      t.change :email, :string, :null=>true
    end
    remove_index :users, :email
    
    
  end   
  
  def down
    # This is the default like device set it up
    change_table :users do |t|
      t.change :email, :string, :null=>false, :default=>''
    end
    add_index :users, :email,                :unique => true
  end  
end
