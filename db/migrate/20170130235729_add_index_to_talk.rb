class AddIndexToTalk < ActiveRecord::Migration[5.0]
  def change
    add_index :talks, [:receiver_id], unique: true
  end
end
