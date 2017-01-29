class CreateCommands < ActiveRecord::Migration[5.0]
  def change
    create_table :commands do |t|
      t.references :command_group
      t.integer :message_type, null: false, limit: 2
      t.text :content
      t.timestamps
    end
  end
end
