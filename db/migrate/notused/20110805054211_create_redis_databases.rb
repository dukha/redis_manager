class CreateRedisDatabases < ActiveRecord::Migration
  def self.up
    create_table :redis_databases do |t|
      t.integer :redis_index
      t.string :name
      t.boolean :server

      t.timestamps
    end
  end

  def self.down
    drop_table :redis_databases
  end
end
