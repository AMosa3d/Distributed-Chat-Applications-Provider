class Api::V1::ChatMessagesController < ApplicationController
  before_action :fetch_chat
  before_action :fetch_chat_message, only: [:show, :update]

  # GET /api/v1/applications/:application_token/chats/:chat_number/messages
  # reads all application's chats
  def index
    json_response(@chat.messages, :ok, except = [:id, :number, :chat_id])
  end

  # GET /api/v1/applications/:application_token/chats/:chat_number/messages/search?query=
  # reads all application's chats
  def search
    json_response(@chat.messages.search(@chat.id, params[:query]), :ok, except = [:id, :chat_id])
  end

  # GET /api/v1/applications/:application_token/chats/:chat_number/messages/:number
  # reads application's chat by its number
  def show
    json_response(@chatMessage, :ok, except = [:id, :chat_id])
  end

  # POST /api/v1/applications/:application_token/chats/:chat_number/messages
  def create
    @chatMessage = ChatMessage.new(creation_params)
    RabbitPublisher.publish('message', @chatMessage)

    json_response(
      {
        :message => "ChatMessage has be created successfully",
        :chat_message => @chatMessage
      }, :created, except = [:id, :chat_id]
    )
  end

  # PUT - PATCH  /api/v1/applications/:application_token/chats/:chat_number/messages/:number
  def update
    @chatMessage.assign_attributes(chat_message_whitelist_params)
    RabbitPublisher.publish('message', @chatMessage)
    json_response(
      {
        :message => "ChatMessage has be updated successfully",
        :chat_message => @chatMessage
      }, :ok, except = [:id, :chat_id]
    )
  end


  private
  # these are the only params that the client should be able to create/update
  def chat_message_whitelist_params
    params.permit(:body)
  end

  # Adds the application's chat number to the creation params
  def creation_params
    return [
      :body => chat_message_whitelist_params[:body],
      :number => $redis.incr(@chat.id.to_s + '_message_number')
    ]
  end

  def fetch_chat
    application = Application.find_by_token!(params[:application_token])
    @chat = application.chats.find_by_number!(params[:chat_number])
  end

  def fetch_chat_message
    @chatMessage = @chat.messages.find_by_number!(params[:number])
  end
end
