class MessagesCountAggregatorJob
  include Sidekiq::Job
  sidekiq_options retry: 3

  def perform
    Chat.aggregate_messages_count
  end
end
