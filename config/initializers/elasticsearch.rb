require 'elasticsearch/model'

Elasticsearch::Model.client = Elasticsearch::Client.new url: 'https://localhost:9200',
                                user: 'elastic',
                                password: '1MagbcdA9zrtRQKRSbro',
                                log:true,
                                transport_options: { ssl: { verify: false }, request: { timeout: 30} }
