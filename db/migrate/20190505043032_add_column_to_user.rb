class AddColumnToUser < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :atmark, :string
    change_column :users, :atmark, :string, {null: false}
    add_index :users, :atmark, unique: true
  end

  def down
    remove_column :users, :atmark
  end
end
