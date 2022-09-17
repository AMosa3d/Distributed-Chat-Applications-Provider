require 'sneakers'

Sneakers.configure log: STDOUT, amqp: 'amqp://guest:guest@rabbitmq', deamonize: true
Sneakers.logger.level = Logger::INFO

# require 'bunny'
#
# connection = Bunny.new ({ host: 'rabbitmq' , user: "guest", password: "guest" })
# connection.start
#
# channel = connection.create_channel
# exchange = channel.fanout('test_exchange')
#
# queue_chats = channel.queue('test_queue', durable: true)
# queue_chats.bind(exchange.name)
#
# connection.close
