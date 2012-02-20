# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 201202532356043) do

  create_table "calmapp_versions", :force => true do |t|
    t.integer  "calmapp_id", :null => false
    t.integer  "version",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "calmapp_versions", ["calmapp_id", "version"], :name => "iu_calmapp_versions_calmapp_id_version", :unique => true
  add_index "calmapp_versions", ["calmapp_id"], :name => "i_calmapp_versions_appliction_id"

  create_table "calmapp_versions_languages", :force => true do |t|
    t.integer "calmapp_version_id", :null => false
    t.integer "language_id",        :null => false
  end

  add_index "calmapp_versions_languages", ["calmapp_version_id", "language_id"], :name => "iu_calmapp_versions_languages_calmapp_id_lanugage_id", :unique => true

  create_table "calmapps", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "calmapps", ["name"], :name => "iu_calmapps_name", :unique => true

  create_table "languages", :force => true do |t|
    t.string   "iso_code",   :null => false
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "languages", ["iso_code"], :name => "iu_languages_iso_code", :unique => true
  add_index "languages", ["name"], :name => "iu_languages_name", :unique => true

  create_table "locations", :force => true do |t|
    t.string   "name",             :null => false
    t.string   "type",             :null => false
    t.integer  "parent_id"
    t.string   "translation_code"
    t.string   "fqdn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "organisation_id", :null => false
    t.integer  "profile_id",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.text     "roles"
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "redis_databases", :force => true do |t|
    t.integer  "calmapp_version_id", :null => false
    t.integer  "redis_instance_id"
    t.integer  "redis_db_index",     :null => false
    t.integer  "release_status_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "redis_instances", :force => true do |t|
    t.string  "host",          :null => false
    t.integer "port",          :null => false
    t.string  "password",      :null => false
    t.integer "max_databases"
    t.string  "description"
  end

  add_index "redis_instances", ["host", "port"], :name => "iu_redis_instances_host_port", :unique => true

  create_table "release_statuses", :force => true do |t|
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tests", :id => false, :force => true do |t|
    t.integer "id",                  :null => false
    t.string  "name", :limit => nil, :null => false
  end

  create_table "translations", :force => true do |t|
    t.string   "dot_key_code",       :null => false
    t.text     "translation",        :null => false
    t.integer  "calmapp_version_id", :null => false
    t.string   "origin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "translations", ["dot_key_code"], :name => "iu_translations_dot_key_code", :unique => true

  create_table "uploads", :force => true do |t|
    t.integer  "language_id",              :null => false
    t.string   "upload_file_name",         :null => false
    t.string   "upload_file_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_file_updated_at"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "uploads", ["upload_file_name"], :name => "iu_uploads_upload_file_name", :unique => true

  create_table "user_works", :force => true do |t|
    t.integer  "user_id"
    t.integer  "translation_language_id",   :null => false
    t.integer  "current_redis_database_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username",               :default => "", :null => false
    t.string   "email",                  :default => ""
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "actual_name"
    t.integer  "current_permission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "whiteboard_types", :force => true do |t|
    t.string   "name_english"
    t.string   "translation_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "whiteboards", :force => true do |t|
    t.text     "info",               :null => false
    t.integer  "whiteboard_type_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "whiteboards", ["whiteboard_type_id"], :name => "iu_whiteboards_whiteboard_type", :unique => true

end
