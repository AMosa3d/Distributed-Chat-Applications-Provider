class Api::V1::ChatsController < ApplicationController
  before_action :fetch_application
  before_action :fetch_chat, only: [:show, :update]

  # GET /api/v1/applications/:application_token/chats
  # reads all application's chats
  def index
    json_response(@application.chats, :ok, except = [:id, :number, :application_id])
  end

  # GET /api/v1/applications/:application_token/chats/:number
  # reads application's chat by its number
  def show
    json_response(@chat, :ok, except = [:id, :application_id])
  end

  # POST /api/v1/applications/:application_token/chats(.:format)
  def create
    @chat = @application.chats.create!(creation_params)
    json_response(
      {
        :message => "Chat has be created successfully",
        :chat => @chat
      }, :created, except = [:id, :messages_count, :application_id]
    )
  end

  # PUT - PATCH  /api/v1/applications/:application_token/chats/:number
  def update
    @chat.update!(chat_whitelist_params)

    json_response(
      {
        :message => "Chat has be updated successfully",
        :chat => @chat
      }, :ok, except = [:id, :application_id]
    )
  end


  private
  # these are the only params that the client should be able to create/update
  def chat_whitelist_params
    params.permit(:name)
  end

  # Adds the application's chat number to the creation params
  def creation_params
    return [
      :name => chat_whitelist_params[:name],
      :number => @application.chats.maximum(:number).to_i + 1
    ]
  end

  def fetch_application
    @application = Application.find_by_token!(params[:application_token])
  end

  def fetch_chat
    @chat = @application.chats.find_by_number!(params[:number])
  end
end
