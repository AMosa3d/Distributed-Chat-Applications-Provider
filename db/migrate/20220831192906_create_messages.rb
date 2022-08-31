class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.string :body
      t.integer :number
      t.references :chat, null: false, foreign_key: true

      t.timestamps

      t.index [:number, :chat_id], unique: true
    end
  end
end
