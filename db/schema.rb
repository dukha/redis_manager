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

ActiveRecord::Schema.define(:version => 20110808235031) do

 
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

  create_table "applications", :force => true do |t|
    t.string     "name", :null=>false
    t.datetime "created_at"
    t.datetime "updated_at"

  end

  create_table "application_versions", :force => true do |t|
    t.integer  "application_id", :null=>false
    t.string   "version", :null=>false
    t.integer  "version_status_id", :null=>false
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  add_index :application_versions, :application_id, :name => "i_application_versions_appliction_id"
  add_index :application_versions, [:application_id, :version], {:unique => true, :name => "iu_application_versions_application_id_version"}

  create_table "uploads", :force => true do |t|
    t.string   "translation_file_name"
    t.string   "translation_file_content_type"
    t.integer  "translation_file_size"
    t.datetime "translation_file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"

  end
  add_index :uploads, :translation_file_name, {:unique=>true, :name=> "iu_uploads_translation_file_name"}

  create_table :redis_databases do |t|
      t.integer :redis_index, :null=>false
      t.string :name, :null=>false
      t.string :host, :null=>false
      t.integer :port, :null=> false
      t.timestamps
  end
  
  add_index :redis_databases, [:redis_index, :host, :port], {:unique => true, :name=>"iu_redis_databases_index_host_port"}
end
