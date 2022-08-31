class Api::V1::ApplicationsController < ApplicationController
  before_action :fetch_application, only: [:show, :update]

  # GET /api/v1/applications
  # reads all the applications
  def index
    @applications = Application.all
    json_response(@applications, :ok, except = [:id, :token])
  end

  # GET /api/v1/applications/:id
  # reads the application by its token
  def show
    json_response(@application, :ok, except = [:id])
  end

  # POST /api/v1/applications
  def create
    @application = Application.create!(creation_params)
    json_response(
      {
        :message => "Application has be created successfully",
        :application => @application
      }, :created, except = [:id, :messages_count]
    )
  end

  # PUT - PATCH  /api/v1/applications/:id
  def update
    @application.update!(application_whitelist_params)

    json_response(
      {
        :message => "Application has be updated successfully",
        :application => @application
      }, :ok, except = [:id]
    )
  end


  private
  # these are the only params that the client should be able to create/update
  def application_whitelist_params
    params.permit(:name)
  end

  # Adds the application generated token to the name param
  def creation_params
    return [
      :name => application_whitelist_params[:name],
      :token => SecureRandom.hex
    ]
  end

  def fetch_application
    @application = Application.find_by_token!(params[:token])
  end
end
