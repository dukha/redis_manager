class CreateWhiteboards < ActiveRecord::Migration
  def self.up
    create_table :whiteboards do |t|
      t.text :info, :null=>false
      t.integer :whiteboard_type_id,  :null=>false
      t.timestamps
    end
  end

  def self.down
    drop_table :whiteboards
  end
end
