class AddMaxDatabasesToRedisInstances < ActiveRecord::Migration
  def up
   add_column :redis_instances,:max_databases, :integer , :nullable=> false
  end
  

  def down
    remove_column :redis_instances, :max_databases
  end
end
