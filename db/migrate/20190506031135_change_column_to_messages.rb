class ChangeColumnToMessages < ActiveRecord::Migration[5.1]
  def up
    change_column :messages, :message, :string, {null: false}
  end

  def down
    remove_column :messages, :message
  end
end
