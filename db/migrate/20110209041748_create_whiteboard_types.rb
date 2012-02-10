class CreateWhiteboardTypes < ActiveRecord::Migration
  def change
    create_table :whiteboard_types do |t|
      t.string :name_english
      t.string :translation_code

      t.timestamps
    end
  end
end
