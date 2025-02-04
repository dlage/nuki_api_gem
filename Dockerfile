FROM ruby:3.0

WORKDIR /usr/src/app

COPY Gemfile .
COPY Gemfile.lock .
COPY nuki_api.gemspec .
COPY lib/nuki_api/version.rb lib/nuki_api/version.rb

RUN bundle install

COPY . .
