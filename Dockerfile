FROM ruby:2.5.7

RUN apt-get update -qq && \
		apt-get install -y build-essential \
                       libpq-dev \
                       nodejs \
                       vim

RUN mkdir /Basyolog

WORKDIR /Basyolog

COPY Gemfile /Basyolog/Gemfile
COPY Gemfile.lock /Basyolog/Gemfile.lock

RUN gem install bundler
RUN bundle install

COPY . /Basyolog
