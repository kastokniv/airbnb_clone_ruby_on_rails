FROM ruby:3.0.0

ENV DATABASE_HOST=db
ENV DATABASE_USERNAME=postgres
ENV DATABASE_PASSWORD=password

RUN mkdir /airbnb_clone
WORKDIR /airbnb_clone

EXPOSE 3000

COPY Gemfile .
COPY Gemfile.lock .
RUN gem update bundler
RUN bundle install

CMD rails server -b 0.0.0.0