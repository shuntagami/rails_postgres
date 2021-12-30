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
eot
COPY package.json yarn.lock /opt/app/
RUN yarn install --frozen-lockfile
COPY Gemfile* .
RUN gem install bundler -N -v $(grep "BUNDLED WITH" -1 Gemfile.lock | tail -n 1) && \
    bundle install --jobs=4 --retry=3 --path=vendor/bundle
COPY . .
EXPOSE 3000
CMD ["docker/startup.sh"]

FROM development AS builder
WORKDIR /opt/app
ENV RAILS_ENV=production
ENV RACK_ENV=production
RUN <<eot
bin/rails webpacker:compile
rm -rf node_modules tmp/cache spec app/javascript .github .git
rm .browserslistrc babel.config.js package.json postcss.config.js yarn.lock .rspec docker-compose.yml Makefile openapi.yaml
eot

FROM ruby:3.0.2-slim AS production
ENV APP_ROOT /opt/app
ENV LANG C.UTF-8
ENV RAILS_ENV=production
ENV RACK_ENV=production
EXPOSE 3000
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev apt-transport-https
WORKDIR /opt/app
COPY --from=builder $APP_ROOT $APP_ROOT
RUN bundle config set path vendor/bundle
CMD ["docker/startup.sh"]
