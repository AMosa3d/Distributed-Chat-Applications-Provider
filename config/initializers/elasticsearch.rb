require 'elasticsearch/model'

Elasticsearch::Model.client = Elasticsearch::Client.new host: 'elasticsearch'
