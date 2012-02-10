class CreateWhiteboards < ActiveRecord::Migration
  def up
    create_table :whiteboards do |t|
      t.text :info, :null=>false
      t.references  :whiteboard_type, :null => false
      t.timestamps
    end
    execute <<-SQL
       Alter table whiteboards
        drop constraint  IF EXISTS fk_whiteboards_whiteboard_types
    SQL
    
    execute <<-SQL
      ALTER TABLE whiteboards
        ADD CONSTRAINT fk_whiteboards_whiteboard_types
        FOREIGN KEY (whiteboard_type_id)
        REFERENCES whiteboard_types(id)
        ON DELETE CASCADE
    SQL
    add_index :whiteboards, :whiteboard_type_id, {:unique=>true, :name=> "iu_whiteboards_whiteboard_type"}
  end

  def down
    execute <<-SQL
       Alter table whiteboards
        drop constraint  IF EXISTS fk_whiteboards_whiteboard_types
    SQL
    drop_table :whiteboards
  end
end
