FROM ruby:2.5.7

RUN apt-get update -qq && \
		apt-get install -y build-essential \
                       libpq-dev \
                       nodejs \
                       vim

RUN mkdir /Basyolog

WORKDIR /Basyolog

ADD Gemfile /Basyolog/Gemfile
ADD Gemfile.lock /Basyolog/Gemfile.lock

RUN gem install bundler
RUN bundle install

ADD . /Basyolog

RUN mkdir -p tmp/sockets
