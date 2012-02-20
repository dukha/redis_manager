class CreateProfiles < ActiveRecord::Migration
  def up
    create_table :profiles do |t|
      t.text :roles
      t.string :name, :null => false
      
      t.timestamps
    end
  end

  def down
    drop_table :profiles
  end
end
