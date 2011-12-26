# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111221002557) do

 
  create_table "version_statuses", :force => true do |t|
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  
  create_table "whiteboard_types", :force => true do |t|
    t.string   "name_english",     :null => false
    t.string   "translation_code", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "whiteboards", :force => true do |t|
    t.text     "info",               :null => false
    t.references  :whiteboard_type, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "languages", :force => true do |t|
    t.string   "iso_code",                            :null => false
    t.string   "name",                                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  add_index :languages, :name, {:unique=>true, :name=> "iu_languages_name"}
  add_index :languages, :iso_code, {:unique=>true, :name=> "iu_languages_iso_code"}

  create_table "calmapps", :force => true do |t|
    t.string     "name", :null=>false
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  add_index :calmapps, :name, {:unique=>true, :name=>"iu_calmapps_name"}

  create_table "calmapp_versions", :force => true do |t|
    t.references  :calmapp, :null=>false
    t.integer   "major_version", :null=>false
    t.references  :version_status, :null=>false

    t.datetime "created_at"
    t.datetime "updated_at"
  end

  execute <<-SQL
       Alter table calmapp_versions
        drop constraint  IF EXISTS  fk_calmapp_versions_version_statuses
    SQL

  execute <<-SQL
      ALTER TABLE calmapp_versions
        ADD CONSTRAINT fk_calmapp_versions_version_statuses
        FOREIGN KEY (version_status_id)
        REFERENCES version_statuses(id)
        ON DELETE RESTRICT
    SQL

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
  add_index :calmapp_versions, [:calmapp_id, :major_version], {:unique => true, :name => "iu_calmapp_versions_calmapp_id_major_version"}


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

  

  
  create_table "uploads", :force => true do |t|
    t.references :language , :null=>false
    t.string   "upload_file_name", :null=>false
    t.string   "upload_file_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_file_updated_at"
    t.string   :description
    t.datetime "created_at"
    t.datetime "updated_at"

  end

  execute <<-SQL
       Alter table uploads
        drop constraint  IF EXISTS fk_uploads_languages
    SQL

  execute <<-SQL
      ALTER TABLE uploads
        ADD CONSTRAINT fk_uploads_languages
        FOREIGN KEY (language_id)
        REFERENCES languages(id)
        ON DELETE CASCADE
    SQL

  add_index :uploads, :upload_file_name, {:unique=>true, :name=> "iu_uploads_upload_file_name"}

  create_table :redis_instances do |t|
    t.string :host, :null=>false
    t.integer :port, :null=> false
    t.string  :password,  :null=> false
  end
  add_index :redis_instances, [ :host, :port], {:unique => true, :name=>"iu_redis_instances_host_port"}

  
  
  create_table :redis_databases do |t|
      t.references :calmapp_version, :null=>false
      t.references :redis_instance, :null=>true
      t.integer :redis_db_index, :null=>false 
      t.timestamps
  end
  execute <<-SQL
       Alter table redis_databases
        drop constraint  IF EXISTS  fk_redis_databases_redis_instances
    SQL

  execute <<-SQL
      ALTER TABLE redis_databases
        ADD CONSTRAINT fk_redis_databases_redis_instances
        FOREIGN KEY (redis_instance_id)
        REFERENCES redis_instances(id)
        ON DELETE RESTRICT
    SQL
  
  execute <<-SQL
       Alter table redis_databases
        drop constraint  IF EXISTS  fk_redis_databases_calmapp_versions
    SQL
    
  execute <<-SQL
      ALTER TABLE redis_databases
        ADD CONSTRAINT fk_redis_databases_calmapp_versions
        FOREIGN KEY (calmapp_version_id)
        REFERENCES calmapp_versions(id)
        ON DELETE RESTRICT
    SQL
  #add_index :redis_databases, [:redis_db_index, :host, :port], {:unique => true, :name=>"iu_databases_index_host_port"}

  create_table :uploads_redis_databases do |t|
    t.references :upload, :null => false
    t.references :redis_database, :null => false
  end

  execute <<-SQL
       Alter table uploads_redis_databases
        drop constraint  IF EXISTS  fk_uploads_redis_databases_uploads
    SQL

  execute <<-SQL
      ALTER TABLE uploads_redis_databases
        ADD CONSTRAINT fk_uploads_redis_databases_uploads
        FOREIGN KEY (upload_id)
        REFERENCES uploads(id)
        ON DELETE RESTRICT
    SQL

  execute <<-SQL
       Alter table uploads_redis_databases
        drop constraint  IF EXISTS  fk_uploads_redis_databases_redis_databases
    SQL

  execute <<-SQL
      ALTER TABLE uploads_redis_databases
        ADD CONSTRAINT fk_uploads_redis_databases_redis_databases
        FOREIGN KEY (redis_database_id)
        REFERENCES redis_databases(id)
        ON DELETE RESTRICT
    SQL
  create_table :user_preferences do |t|
    t.integer :user_id
    t.references :translation_language, :null=> false
    t.references :current_redis_database, :null=> false
    t.timestamps
  end  
  create_table :translations do |t|
    t.string :dot_key_code, :null=> false 
    t.text :translation,    :null=> false
    # origin is the name of the file if it was bulk loaded from a yaml file
    t.string :origin
    #t.reference :user, :null=> false
    t.timestamps
  end
end
