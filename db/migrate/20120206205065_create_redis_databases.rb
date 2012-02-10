class CreateRedisDatabases < ActiveRecord::Migration
  def up
     create_table :redis_databases do |t|
      t.references :calmapp_version, :null=>false
      t.references :redis_instance, :null=>true
      t.integer :redis_db_index, :null=>false 
      t.references  :release_status, :null=>false
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
    
  execute <<-SQL
       Alter table redis_databases
        drop constraint  IF EXISTS  fk_redis_databases_release_statuses
    SQL

  execute <<-SQL
      ALTER TABLE redis_databases
        ADD CONSTRAINT fk_redis_databases_release_statuses
        FOREIGN KEY (release_status_id)
        REFERENCES release_statuses(id)
        ON DELETE RESTRICT
    SQL
    
  end

  def down
    
    execute <<-SQL
       Alter table redis_databases
        drop constraint  IF EXISTS  fk_redis_databases_redis_instances
    SQL
    
    execute <<-SQL
       Alter table redis_databases
        drop constraint  IF EXISTS  fk_redis_databases_calmapp_versions
    SQL
    
    execute <<-SQL
       Alter table redis_databases
        drop constraint  IF EXISTS  fk_calmapp_versions_release_statuses
    SQL
    
    drop_table :redis_databases
  end
end
