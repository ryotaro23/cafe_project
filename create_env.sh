#!/bin/sh

mkdir web
touch web/Dockerflle

touch docker-compose.yml


# Gemfileの作製
bundle init

touch Gemfile.lock

docker-compose run web rails new . --force --no-deps --database=postgresql --skip-bundle