class AddChatsCountToApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :applications, :chats_count, :integer, default: 0
  end
end
