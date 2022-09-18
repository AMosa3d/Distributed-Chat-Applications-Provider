
class RabbitConsumer
  include Sneakers::Worker

  from_queue "test_queue", env: nil

  def work(message)
    logger.info("--------- RabbitConsumer: " + message)
    ack!
  end
end
