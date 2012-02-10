class CreateCalmapps < ActiveRecord::Migration
  def up
    create_table "calmapps", :force => true do |t|
    t.string     "name", :null=>false
    
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  add_index :calmapps, :name, {:unique=>true, :name=>"iu_calmapps_name"}
  end

  def down
    drop_table :calmapps;
  end
end
