FROM ruby:2.3
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY Gemfile /usr/src/app
RUN bundle install
COPY . /usr/src/app
CMD ["pry"]
VOLUME /usr/src/app
VOLUME /usr/local/bundle
