class CreateTranslations < ActiveRecord::Migration
  def up
    create_table :translations do |t|
    t.string :dot_key_code, :null=> false 
    t.text :translation,    :null=> false
    t.references :calmapp_version, :null=> false
    # origin is the name of the file if it was bulk loaded from a yaml file
    t.string :origin
    #t.reference :user, :null=> false
    t.timestamps
  end
  add_index :translations, :dot_key_code, {:unique=>true, :name => "iu_translations_dot_key_code"}
  
  execute <<-SQL
       Alter table translations
        drop constraint  IF EXISTS  fk_translations_calmapp_versions
    SQL
    
   execute <<-SQL
      ALTER TABLE translations
        ADD CONSTRAINT fk_translations_calmapp_versions
        FOREIGN KEY (calmapp_version_id)
        REFERENCES calmapp_versions(id)
        ON DELETE RESTRICT
    SQL
  end

  def down
    execute <<-SQL
       Alter table translations
        drop constraint  IF EXISTS  fk_translations_calmapp_versions
    SQL
    drop_table :translations
  end
end
