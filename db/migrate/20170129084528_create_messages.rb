class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :message_type, null: false, limit: 2
      t.references :talk
      t.references :event
      t.text :content
      t.timestamps
    end
    add_index :messages, [:talk_id, :message_type, :created_at]
  end
end
