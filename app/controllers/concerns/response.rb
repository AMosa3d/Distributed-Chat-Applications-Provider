module Response
  def json_response(response, status = :ok, except = nil)
    render json: response, status: status, except: except
  end
end
