class CreateTranslationUploads < ActiveRecord::Migration
  def self.up
    create_table :translation_uploads do |t|
      t.string :translation_file_name
      t.string :translation_file_content_type
      t.integer :translation_file_size
      t.datetime :translation_file_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :translation_uploads
  end
end
