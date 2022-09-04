require 'elasticsearch/model'

Elasticsearch::Model.client = Elasticsearch::Client.new url: 'http://elasticsearch:9200'
