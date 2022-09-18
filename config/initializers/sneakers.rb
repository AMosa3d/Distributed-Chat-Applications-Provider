require 'sneakers'

Sneakers.configure log: STDOUT, amqp: 'amqp://guest:guest@rabbitmq', deamonize: true
Sneakers.logger.level = Logger::INFO

require 'bunny'

connection = Bunny.new ({ host: 'rabbitmq' , user: "guest", password: "guest" })
connection.start

channel = connection.create_channel

chatsExchange = channel.direct('chats_exchange')
chatsQueue = channel.queue('chats_queue', durable: true)
chatsQueue.bind(chatsExchange.name)

messagesExchange = channel.direct('messages_exchange')
messagesQueue = channel.queue('messages_queue', durable: true)
messagesQueue.bind(messagesExchange.name)

connection.close
