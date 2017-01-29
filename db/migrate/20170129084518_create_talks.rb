class CreateTalks < ActiveRecord::Migration[5.0]
  def change
    create_table :talks do |t|
      t.integer :talk_type, null: false, limit: 2, default: 0
      t.string :receiver_id, null: false
      t.integer :status, null: false, limit: 2
      t.timestamps
    end
    add_index :talks, [:talk_type, :receiver_id], unique: true
    add_index :talks, [:status]
  end
end
