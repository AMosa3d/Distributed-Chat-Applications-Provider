class ChatMessage < ApplicationRecord
  # Since I have decided to make the class name slightly different than the db table
  # since it may be confusing in code, it should be implicitly mapped here
  self.table_name = 'messages'

  belongs_to :chat
end
