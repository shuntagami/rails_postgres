# syntax=docker/dockerfile:1.3-labs

FROM ruby:3.0.2-slim AS development

WORKDIR /opt/app

RUN <<eot
apt-get update -qq && apt-get install -y build-essential libpq-dev apt-transport-https curl git wget
curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
apt-get install -y nodejs
wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list
apt update -qq && apt-get install -y yarn
gem install bundler
eot

COPY package.json yarn.lock /opt/app/
RUN yarn install --frozen-lockfile
COPY Gemfile* .
RUN bundle install --jobs=4 --retry=3 --path=vendor/bundle
COPY . .

EXPOSE 3000
CMD ["docker/startup.sh"]

FROM development AS builder
ENV RAILS_ENV=production
ENV RACK_ENV=production
RUN bin/rails webpacker:compile

FROM ruby:3.0.2-slim AS production
ENV APP_ROOT /opt/app
ENV LANG C.UTF-8
ENV RAILS_ENV=production
ENV RACK_ENV=production
EXPOSE 3000

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev apt-transport-https
WORKDIR /opt/app

COPY --from=builder /opt/app /opt/app/
RUN bundle config set path vendor/bundle

CMD ["docker/startup.sh"]
