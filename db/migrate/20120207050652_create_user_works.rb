class CreateUserWorks < ActiveRecord::Migration
  def up
    create_table :user_works do |t|
    t.integer :user_id
    t.references :translation_language, :null=> false
    t.references :current_redis_database, :null=> false
    t.timestamps
  end
  
  execute <<-SQL
       Alter table user_works
        drop constraint  IF EXISTS  fk_user_works_language
    SQL
    
  execute <<-SQL
      ALTER TABLE user_works
        ADD CONSTRAINT fk_user_works_language
        FOREIGN KEY (translation_language_id)
        REFERENCES languages(id)
        ON DELETE RESTRICT
    SQL
    
    execute <<-SQL
       Alter table user_works
        drop constraint  IF EXISTS  fk_user_works_language
    SQL
    
  execute <<-SQL
      ALTER TABLE user_works
        ADD CONSTRAINT fk_user_work_redis_database
        FOREIGN KEY (current_redis_database_id)
        REFERENCES redis_databases(id)
        ON DELETE RESTRICT
    SQL
  end

  def down
    execute <<-SQL
       Alter table user_works
        drop constraint  IF EXISTS  fk_user_works_language
    SQL
    execute <<-SQL
       Alter table user_works
        drop constraint  IF EXISTS  fk_user_works_language
    SQL
    drop_table :user_works
    
  end
end
