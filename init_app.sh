#!/bin/bash
rails db:create
rails db:migrate
rm tmp/pids/server.pid
rails server -b 0.0.0.0
redis-server --daemonize yes
sidekiq restart
