class CreateApplications < ActiveRecord::Migration
  def self.up
    create_table :applications do |t|
      t.text :name
      t.text :version
      t.boolean :frozen

      t.timestamps
    end
  end

  def self.down
    drop_table :applications
  end
end
