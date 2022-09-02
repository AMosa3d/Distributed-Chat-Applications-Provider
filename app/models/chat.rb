class Chat < ApplicationRecord
  belongs_to :application
  # Since I have decided to make the class name slightly different than the db table
  # since it may be confusing in code, it should be implicitly mapped here
  has_many :messages, foreign_key: 'chat_id', class_name: 'ChatMessage'

  validates :name, presence: {:message => 'Chat should have a name'}
  validates :number, presence: {:message => "Chat should have a number"}
  validates :application_id, presence: {:message => "Chat should be related to an application"}

  def self.aggregate_messages_count
    self.connection.execute(
      'UPDATE chats chats
       JOIN(
         SELECT chat_id, COUNT(chat_id) as aggregation
         FROM messages
         GROUP BY chat_id
       ) msgs ON chats.id = msgs.chat_id
       SET chats.messages_count = msgs.aggregation;'
    )
  end
end
