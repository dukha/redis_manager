class CreateLocations < ActiveRecord::Migration
  def up
    create_table :locations do |t|
      t.string :name, :null=>false
      t.string :type, :null=>false
      t.integer :parent_id
      # not all locations need to be translated as you go down the tree
      t.string :translation_code, :null => true
      t.string :fqdn
      t.timestamps
    end
  end

  def down
    drop_table :locations
  end
end
