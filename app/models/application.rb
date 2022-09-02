class Application < ApplicationRecord
  has_many :chats
  before_validation :generate_token, on: :create

  validates :name, presence: {:message => 'Application should have a name'}
  validates :token, presence: {:message => "Token field can't be blank"}

  def generate_token
    # This is the simpliest way to create a token, I thought that there is no
    # need to use JWT token here.

    # NOTE: there is a read (maybe more but the porbability is too low) from the
    # database, it's not the best in the world, but judging from the use case,
    # and that the creation requests on the application table is not that high,
    # we can avoid complicating the token generation more than that.
    self.token = loop do
      generatedToken = SecureRandom.hex(32)
      break generatedToken unless Application.exists?(token: generatedToken)
    end
  end

  def self.aggregate_chats_count
    # Their might be an ActiveRecord-based approach but I couldn't find any.
    self.connection.execute(
      'UPDATE applications apps
       JOIN(SELECT application_id, COUNT(application_id) as aggregation
       FROM chats
       GROUP BY application_id) c ON apps.id = c.application_id
       SET apps.chats_count = c.aggregation;'
    )
  end
end
