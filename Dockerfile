FROM ruby:3.0.0

RUN apt-get update -qq && \
  apt-get install -y build-essential \
  nodejs\
  mysql-server\
  mysql-client

WORKDIR /saving

COPY Gemfile /saving/Gemfile
COPY Gemfile.lock /saving/Gemfile.lock

RUN gem install bundler
RUN bundle install

RUN mkdir -p tmp/sockets