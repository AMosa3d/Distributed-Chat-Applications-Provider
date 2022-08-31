require "swagger_helper"

RSpec.describe "api/v1/chats_controller", type: :request do

  path "/api/v1/applications/:application_token/chats" do

    get "Retrieves all the created chats for the given token's application" do
      tags "Chats"
      produces "application_token/json"
      parameter name: :token, in: :path, type: :string
      response '200', 'Chats retrieved' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              name: { type: :string },
              messages_count: { type: :integer },
              created_at: { type: :string },
              updated_at: { type: :string }
            },
            required: ['name', 'created_at', 'updated_at']
          }

          let(:chat) {}
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


    post "Creates a new chat that will be linked to the given token's application" do
      tags "Chats"
      consumes "application/json"
      produces "application/json"
      parameter name: :application_token, in: :path, type: :string
      parameter name: :chat, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: ['name'],
      }
      response "201", "Application created successfully" do
        schema type: :object,
          properties: {
            message: { type: :string },
            chat: { type: :object,
              properties: {
                name: { type: :string },
                number: { type: :integer },
                created_at: { type: :string },
                updated_at: { type: :string }
              },
              required: ['name', 'number', 'created_at', 'updated_at']
            }
          },
          required: ['message', 'chat']

        let(:chat) {}
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

  path "/api/v1/applications/:application_token/chats/:number" do

    get "Retrieves the given token's application's chat" do
      tags "Chats"
      produces "application/json"
      parameter name: :application_token, in: :path, type: :string
      parameter name: :number, in: :path, type: :integer
      response '200', 'Applications retrieved' do
        schema type: :object,
          properties: {
            name: { type: :string },
            number: { type: :integer },
            messages_count: { type: :integer },
            created_at: { type: :string },
            updated_at: { type: :string }
          },
          required: ['name', 'number', 'created_at', 'updated_at']

          let(:chat) {}
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


    put "Update Chat of the given token's application" do
      tags "Chats"
      consumes "application/json"
      produces "application/json"
      parameter name: :token, in: :path, type: :string
      parameter name: :chat, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: ['name'],
      }
      response "200", "Application updated successfully" do
        schema type: :object,
          properties: {
            message: { type: :string },
            chat: { type: :object,
              properties: {
                name: { type: :string },
                number: { type: :integer },
                messages_count: { type: :integer },
                created_at: { type: :string },
                updated_at: { type: :string }
              },
              required: ['name', 'number', 'created_at', 'updated_at']
            }
          },
          required: ['message', 'chat']

        let(:chat) {}
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
