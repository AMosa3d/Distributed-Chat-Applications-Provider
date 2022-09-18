require 'sneakers'
require 'json'

class MessagesRabbitConsumer
  include Sneakers::Worker

  from_queue "messages_queue", env: nil,
  exchange: 'messages_exchange', exchange_type: :direct

  def work(queue_message)
    logger.info("--------- MessagesRabbitConsumer: " + queue_message)
    message_params = JSON.parse(queue_message)

    chat_message = ChatMessage.new(message_params)
    chat_message.save!
    ack!
    logger.info("--------- MessagesRabbitConsumer: Saved successfully")
  end
end
