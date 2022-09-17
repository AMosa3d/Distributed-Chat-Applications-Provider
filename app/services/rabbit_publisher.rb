class RabbitPublisher

  def self.connection
    @connection ||= Bunny.new ({ host: 'rabbitmq' })
    @connection.start
  end

  def self.channel
    @channel ||= ConnectionPool.new do
      connection.create_channel
    end
  end

  def self.publish(type, message_obj)
    channel.with do |channel|
      exchange_name = get_exchange_name(type)
      exchange = channel.direct(exchange_name)
      exchange.publish(message_obj.to_json)
      # queue_chats = channel.queue('test_queue', durable: true)
      # channel.default_exchange.publish(message_obj, routing_key: queue_chats.name)
    end
  end

  private

  # TODO: this is SOLID, better use factory, with DI it would be better
  def self.get_exchange_name(type)
    return (type == 'chat') ? 'chats_exchange' : 'messages_exchange'
  end
end
