FROM ruby:2.6.5-stretch
RUN apt-get update -qq && apt-get install -y build-essential  mysql-client vim libjemalloc-dev libjemalloc1 rsyslog
RUN apt-get -y install curl
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install nodejs
RUN npm install -g yarn

RUN mkdir /myapp

WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle config git.allow_insecure true
#RUN bundle update
RUN bundle install



