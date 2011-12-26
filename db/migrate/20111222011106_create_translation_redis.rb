class CreateTranslationRedis < ActiveRecord::Migration
  def self.up
    create_table :translation_redis do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :translation_redis
  end
end
