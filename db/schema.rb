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

ActiveRecord::Schema.define(:version => 20110915235234) do

 
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
    t.integer  "whiteboard_type_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end
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

  create_table :calmapps_languages, :force=> true do |t|
    t.references :calmapp, :null=>false
    t.references :language, :null=> false
  end
  add_index :calmapps_languages, [:calmapp_id, :language_id], {:unique=>true, :name=>"iu_calmapps_languages_calmapp_id_lanugae_id" }

  create_table "calmapp_versions", :force => true do |t|
    t.references  :calmapp, :null=>false
    t.integer   "major_version", :null=>false
    t.integer  "version_status_id", :null=>false
    #t.references  :translation, :null=> false
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  add_index :calmapp_versions, :calmapp_id, :name => "i_calmapp_versions_appliction_id"
  add_index :calmapp_versions, [:calmapp_id, :major_version], {:unique => true, :name => "iu_calmapp_versions_calmapp_id_major_version"}

  create_table "uploads", :force => true do |t|
    t.references :calmapps_language , :null=>false
    t.string   "upload_file_name", :null=>false
    t.string   "upload_file_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_file_updated_at"
    t.string   :description
    t.datetime "created_at"
    t.datetime "updated_at"

  end

  add_index :uploads, :upload_file_name, {:unique=>true, :name=> "iu_uploads_upload_file_name"}

  create_table :redis_databases do |t|
      t.references :calmapp_version, :null=>false
      t.integer :redis_db_index, :null=>false
      
      t.string :host, :null=>false
      t.integer :port, :null=> false
      t.timestamps
  end
  execute <<-SQL
      ALTER TABLE redis_databases
        ADD CONSTRAINT fk_redis_databases_calmapp_versions
        FOREIGN KEY (calmapp_version_id)
        REFERENCES calmapp_versions(id)
    SQL
  add_index :redis_databases, [:redis_db_index, :host, :port], {:unique => true, :name=>"iu_databases_index_host_port"}

 # create_table :redis_admins do |t|
     # t.integer :max_redis_dbs, :null=>false

     # t.timestamps
    #end
end
