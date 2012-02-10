class CreateLanguages < ActiveRecord::Migration
  def up
    create_table :languages do |t|
      t.string :iso_code, :null=>false
      t.string :name, :null=>false
      

      t.timestamps
    end
    add_index :languages, :name, {:unique=>true, :name=> "iu_languages_name"}
    add_index :languages, :iso_code, {:unique=>true, :name=> "iu_languages_iso_code"}
  end

  def down
    drop_table :languages
  end
end
