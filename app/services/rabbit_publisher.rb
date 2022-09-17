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

  def self.publish(queue_name, message_obj)
    channel.with do |channel|
      exchange = channel.direct('chats_exchange')
      exchange.publish(message_obj)
      # queue_chats = channel.queue('test_queue', durable: true)
      # channel.default_exchange.publish(message_obj, routing_key: queue_chats.name)
    end
  end
end
