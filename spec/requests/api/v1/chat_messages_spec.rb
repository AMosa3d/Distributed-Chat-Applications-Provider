require "swagger_helper"

RSpec.describe "api/v1/chat_messages_controller", type: :request do

  path "/api/v1/applications/:application_token/chats/:chat_number/messages" do

    get "Retrieves all the created messages for the given number's chat" do
      tags "Chat Messages"
      produces "application_token/json"
      parameter name: :application_token, in: :path, type: :string
      parameter name: :chat_number, in: :path, type: :string
      response '200', 'Chat\'s Messages retrieved' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              body: { type: :string },
              created_at: { type: :string },
              updated_at: { type: :string }
            },
            required: ['body', 'created_at', 'updated_at']
          }

          let(:chatMessage) {}
        run_test!
      end
      response "422", "Invalid request" do
        schema type: :object,
          properties: {
            message: { type: :string }
          },
          required: ['message']

        let(:message) {}
        run_test!
      end
    end


    post "Creates a new message in the given number's chat" do
      tags "Chat Messages"
      consumes "application/json"
      produces "application/json"
      parameter name: :application_token, in: :path, type: :string
      parameter name: :chat_number, in: :path, type: :string
      parameter name: :message, in: :body, schema: {
        type: :object,
        properties: {
          body: { type: :string }
        },
        required: ['name'],
      }
      response "201", "Application created successfully" do
        schema type: :object,
          properties: {
            message: { type: :string },
            chat_message: { type: :object,
              properties: {
                body: { type: :string },
                number: { type: :integer },
                created_at: { type: :string },
                updated_at: { type: :string }
              },
              required: ['name', 'number', 'created_at', 'updated_at']
            }
          },
          required: ['message', 'chat_message']

        let(:ChatMessage) {}
        run_test!
      end
      response "422", "Invalid request" do
        schema type: :object,
          properties: {
            message: { type: :string }
          },
          required: ['message']

        let(:message) {}
        run_test!
      end
    end

  end

################################################################################

  path "/api/v1/applications/:application_token/chats/:chat_number/messages/:number" do

    get "Retrieves the given number's chat's message" do
      tags "Chat Messages"
      produces "application/json"
      parameter name: :application_token, in: :path, type: :string
      parameter name: :chat_number, in: :path, type: :integer
      parameter name: :number, in: :path, type: :integer
      response '200', 'Applications retrieved' do
        schema type: :object,
          properties: {
            body: { type: :string },
            number: { type: :integer },
            created_at: { type: :string },
            updated_at: { type: :string }
          },
          required: ['body', 'number', 'created_at', 'updated_at']

          let(:chatMessage) {}
        run_test!
      end
      response "422", "Invalid request" do
        schema type: :object,
          properties: {
            message: { type: :string }
          },
          required: ['message']

        let(:message) {}
        run_test!
      end
    end


    put "Update message of the given number's chat" do
      tags "Chat Messages"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :path, type: :string
      parameter name: :chat_number, in: :path, type: :string
      parameter name: :number, in: :path, type: :string
      parameter name: :chat_message, in: :body, schema: {
        type: :object,
        properties: {
          body: { type: :string }
        },
        required: ['body'],
      }
      response "200", "Application updated successfully" do
        schema type: :object,
          properties: {
            message: { type: :string },
            chat_message: { type: :object,
              properties: {
                body: { type: :string },
                number: { type: :integer },
                created_at: { type: :string },
                updated_at: { type: :string }
              },
              required: ['body', 'number', 'created_at', 'updated_at']
            }
          },
          required: ['message', 'chat']

        let(:chatMessage) {}
        run_test!
      end
      response "422", "Invalid request" do
        schema type: :object,
          properties: {
            message: { type: :string }
          },
          required: ['message']

        let(:message) {}
        run_test!
      end
    end

  end

################################################################################

  path "/api/v1/applications/:application_token/chats/:chat_number/messages/search?query=:query" do

    get "Retrieves messages using ElasticSearch" do
      description "Retrieves messages with bodies that contain 1 or more words from the given search query, case-insensitively"
      tags ["Chat Messages", "ElasticSearch"]
      produces "application_token/json"
      parameter name: :application_token, in: :path, type: :string
      parameter name: :chat_number, in: :path, type: :string
      parameter name: :query, in: :query, type: :string, required: true
      response '200', 'Chat\'s Messages retrieved' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              body: { type: :string },
              number: { type: :integer },
              created_at: { type: :string },
              updated_at: { type: :string }
            },
            required: ['body', 'number', 'created_at', 'updated_at']
          }

          let(:chatMessage) {}
        run_test!
      end
      response "422", "Invalid request" do
        schema type: :object,
          properties: {
            message: { type: :string }
          },
          required: ['message']

        let(:message) {}
        run_test!
      end
    end

  end


end
