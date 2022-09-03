class ChatsCountAggregatorJob
  include Sidekiq::Job
  sidekiq_options retry: 3

  def perform
    Application.aggregate_chats_count
  end
end
