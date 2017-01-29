class CreateCommandGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :command_groups do |t|
      t.string :name, null: false
      t.timestamps
    end
    add_index :command_groups, [:name]
  end
end
