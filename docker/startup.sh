#! /bin/sh

set -eux

./docker/prepare-db.sh
rm -rf tmp/pids/*
bundle exec puma -C config/puma.rb
bundle exec rails webpacker:compile
# bin/rails s -b 0.0.0.0
