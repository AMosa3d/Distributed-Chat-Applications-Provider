class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.string :name
      t.integer :number
      t.integer :messages_count, default: 0
      t.references :application, null: false, foreign_key: true

      t.index [:number, :application_id], unique: true

      t.timestamps
    end
  end
end
