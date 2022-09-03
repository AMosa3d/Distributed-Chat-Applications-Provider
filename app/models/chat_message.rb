class ChatMessage < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  # Since I have decided to make the class name slightly different than the db table
  # since it may be confusing in code, it should be implicitly mapped here
  self.table_name = 'messages'

  belongs_to :chat

  def self.search(chatId, searchQuery)
    searchBody = {
      query: {
        bool: {
          must: [
            {
              term: {
                chat_id: chatId
              }
            },
            match: {
              body: searchQuery
            }
          ]
        }
      }
    }

    self.__elasticsearch__.search(searchBody).map{|elkElement| elkElement[:_source]}
  end
end
