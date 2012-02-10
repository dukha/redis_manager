class CreateReleaseStatuses < ActiveRecord::Migration
  def up
    create_table "release_statuses", :force => true do |t|
      t.string   "status"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def down
    drop_table :release_statuses
  end
end
