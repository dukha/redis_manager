class CreateCalmappVersionsLanguages < ActiveRecord::Migration
  def up
    create_table :calmapp_versions_languages, :force=> true do |t|
    t.references :calmapp_version, :null=>false
    t.references :language, :null=> false
  end
  
   execute <<-SQL
       Alter table calmapp_versions_languages
        drop constraint  IF EXISTS  fk_calmappv_versions_languages_calmapp_versions
    SQL

  execute <<-SQL
      ALTER TABLE calmapp_versions_languages
        ADD CONSTRAINT fk_calmappv_versions_languages_calmapp_versions
        FOREIGN KEY (calmapp_version_id)
        REFERENCES calmapp_versions(id)
        ON DELETE CASCADE
    SQL

  

  execute <<-SQL
       Alter table calmapp_versions_languages
        drop constraint  IF EXISTS fk_calmapp_versions_languages_languages
    SQL

  execute <<-SQL
      ALTER TABLE calmapp_versions_languages
        ADD CONSTRAINT fk_calmapp_versions_languages_languages
        FOREIGN KEY (language_id)
        REFERENCES languages(id)
        ON DELETE CASCADE
    SQL

  add_index :calmapp_versions_languages, [:calmapp_version_id, :language_id], {:unique=>true, :name=>"iu_calmapp_versions_languages_calmapp_id_lanugage_id" }

  
  end

  def down
     execute <<-SQL
       Alter table calmapp_versions_languages
        drop constraint  IF EXISTS  fk_calmappv_versions_languages_calmapp_versions
    SQL
    execute <<-SQL
       Alter table calmapp_versions_languages
        drop constraint  IF EXISTS fk_calmapp_versions_languages_languages
    SQL
  end
end
