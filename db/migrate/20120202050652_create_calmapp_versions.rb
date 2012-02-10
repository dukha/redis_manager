class CreateCalmappVersions < ActiveRecord::Migration
  def up
    create_table "calmapp_versions", :force => true do |t|
    t.references  :calmapp, :null=>false
    t.integer   "version", :null=>false

    t.datetime "created_at"
    t.datetime "updated_at"
  end

  execute <<-SQL
       Alter table calmapp_versions
        drop constraint  IF EXISTS fk_calmapp_versions_calmapps
    SQL

  execute <<-SQL
      ALTER TABLE calmapp_versions
        ADD CONSTRAINT fk_calmapp_versions_calmapps
        FOREIGN KEY (calmapp_id)
        REFERENCES calmapps(id)
        ON DELETE RESTRICT
    SQL

  add_index :calmapp_versions, :calmapp_id, :name => "i_calmapp_versions_appliction_id"
  add_index :calmapp_versions, [:calmapp_id, :version], {:unique => true, :name => "iu_calmapp_versions_calmapp_id_version"}

  end

  def down
    execute <<-SQL
       Alter table calmapp_versions
        drop constraint  IF EXISTS fk_calmapp_versions_calmapps
    SQL
    drop_table :calmapp_versions
  end
end
