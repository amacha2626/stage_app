FROM ruby:2.5.3

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs \
                       vim nginx

ADD ./container/nginx/unicorn.conf /etc/nginx/conf.d/unicorn.conf

RUN mkdir /stage

ENV APP_ROOT /stage
WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock
RUN bundle install
ADD . $APP_ROOT