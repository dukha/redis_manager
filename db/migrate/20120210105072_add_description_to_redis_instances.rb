class AddDescriptionToRedisInstances < ActiveRecord::Migration
  def up
   add_column :redis_instances,:description, :string , :nullable=> true
  end
  

  def down
    remove_column :redis_instances, :description
  end
end
