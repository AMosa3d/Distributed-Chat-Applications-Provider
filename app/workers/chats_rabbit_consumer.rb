require 'sneakers'
require 'json'

class ChatsRabbitConsumer
  include Sneakers::Worker

  from_queue "chats_queue", env: nil,
  exchange: 'chats_exchange', exchange_type: :direct

  def work(queue_message)
    logger.info("--------- ChatsRabbitConsumer: " + queue_message)
    chat_params = JSON.parse(queue_message)

    chat = Chat.new(chat_params)
    chat.save!
    ack!
    logger.info("--------- ChatsRabbitConsumer: Saved successfully")
  end
end
