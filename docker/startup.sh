#! /bin/sh

set -eux

./docker/prepare-db.sh
rm -rf tmp/pids/*
bundle exec puma -C config/puma.rb
