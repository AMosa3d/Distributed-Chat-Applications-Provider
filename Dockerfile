FROM ruby:3.0.2
RUN apt-get update && apt-get install -y build-essential
RUN apt-get install -y redis-server
RUN apt-get install -y cron

RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY init_app.sh /usr/bin/
RUN chmod +x /usr/bin/init_app.sh
ENTRYPOINT ["init_app.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
