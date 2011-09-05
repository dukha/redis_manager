class CreateRedisAdmins < ActiveRecord::Migration
  def self.up
    create_table :redis_admins do |t|
      t.integer :max_redis_dbs

      t.timestamps
    end
  end

  def self.down
    drop_table :redis_admins
  end
end
