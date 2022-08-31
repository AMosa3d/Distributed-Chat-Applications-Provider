require "swagger_helper"

RSpec.describe "api/v1/application_controller", type: :request do

  path "/api/v1/applications" do

    get "Retrieves all the created applications" do
      tags "Application"
      produces "application/json"
      response '200', 'Applications retrieved' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              name: { type: :string },
              created_at: { type: :string },
              updated_at: { type: :string }
            },
            required: [ 'name', 'created_at', 'updated_at' ]
          }

          let(:application) {}
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


    post "Creates a new Application" do
      tags "Application"
      consumes "application/json"
      produces "application/json"
      parameter name: :application, in: :body, schema: {
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
            application: { type: :object,
              properties: {
                name: { type: :string },
                token: { type: :string },
                created_at: { type: :string },
                updated_at: { type: :string }
              },
              required: ['name', 'token', 'created_at', 'updated_at']
            }
          },
          required: ['message', 'application']

        let(:application) {}
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

  path "/api/v1/applications/{token}" do

    get "Retrieves the given token's applications" do
      tags "Application"
      produces "application/json"
      parameter name: :token, in: :path, type: :string
      response '200', 'Applications retrieved' do
        schema type: :object,
          properties: {
            name: { type: :string },
            token: { type: :string },
            created_at: { type: :string },
            updated_at: { type: :string }
          },
          required: [ 'name', 'token', 'created_at', 'updated_at' ]

          let(:application) {}
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


    put "Update Application" do
      tags "Application"
      consumes "application/json"
      produces "application/json"
      parameter name: :application, in: :body, schema: {
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
            application: { type: :object,
              properties: {
                name: { type: :string },
                token: { type: :string },
                created_at: { type: :string },
                updated_at: { type: :string }
              },
              required: ['name', 'token', 'created_at', 'updated_at']
            }
          },
          required: ['message', 'application']

        let(:application) {}
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
