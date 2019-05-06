class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :message
      # 外部キーにした方がいいが設計方法がわからない
      t.integer :send_user_id, null: false
      t.references :room, foreign_key: true

      t.timestamps
    end
  end
end
