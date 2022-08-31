class Chat < ApplicationRecord
  belongs_to :application

  validates :name, presence: {:message => 'Chat should have a name'}
  validates :number, presence: {:message => "Chat should have a number"}
  validates :application_id, presence: {:message => "Chat should be related to an application"}
end
