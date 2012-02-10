class CreateUploads < ActiveRecord::Migration
  def up
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

  end

  def down
    execute <<-SQL
       Alter table uploads
        drop constraint  IF EXISTS fk_uploads_languages
    SQL
    drop_table :uploads
  end
end
