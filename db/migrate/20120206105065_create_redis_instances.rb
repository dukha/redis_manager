class CreateRedisInstances < ActiveRecord::Migration
  def up
    create_table :redis_instances do |t|
    t.string :host, :null=>false
    t.integer :port, :null=> false
    t.string  :password,  :null=> false
  end
  add_index :redis_instances, [ :host, :port], {:unique => true, :name=>"iu_redis_instances_host_port"}

    
  end

  def down
    drop_table :redis_instances
  end
end
