#!/bin/bash

if [ "$1" = "web" ]
then
  bash -c "rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"

elif [ "$1" = "worker" ]
then
  bundle exec sidekiq -c 8 -q default
fi
