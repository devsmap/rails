FROM ruby:2.7

RUN apt-get update -qq && apt-get install -y postgresql-client nodejs shared-mime-info

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

ENTRYPOINT ["./entrypoint.sh"]

EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]