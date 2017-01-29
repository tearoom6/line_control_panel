class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.integer :event_type, null: false, limit: 2
      t.references :talk
      t.datetime :timestamp
      t.text :content
      t.timestamps
    end
    add_index :events, [:event_type, :talk_id, :timestamp]
    add_index :events, [:timestamp]
  end
end
