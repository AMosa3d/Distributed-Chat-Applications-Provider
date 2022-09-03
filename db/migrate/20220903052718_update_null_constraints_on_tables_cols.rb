class UpdateNullConstraintsOnTablesCols < ActiveRecord::Migration[7.0]
  def change
    change_column_null :applications, :name, false
    change_column_null :applications, :token, false
    change_column_null :applications, :chats_count, false

    change_column_null :chats, :name, false
    change_column_null :chats, :number, false
    change_column_null :chats, :messages_count, false

    change_column_null :messages, :body, false
    change_column_null :messages, :number, false
  end
end
