FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

ENV APP_ROOT /sample_app

RUN mkdir $APP_ROOT

WORKDIR $APP_ROOT
# ADD Gemfile $APP_ROOT
# ADD Gemfile.lock $APP_ROOT
COPY Gemfile $APP_HOME/Gemfile
COPY Gemfile.lock $APP_HOME/Gemfile.lock

RUN bundle config --global build.nokogiri --use-system-libraries
RUN  bundle install
ADD . $APP_ROOT

CMD ["set", "-e"]
EXPOSE 3000
# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
