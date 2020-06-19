FROM ruby:2.7.1

RUN apt-get update -qq

ENV APP_HOME /spacex_gallery
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
ADD Gemfile.lock* $APP_HOME/

RUN apt-get update

ADD . $APP_HOME

EXPOSE 9000

ENTRYPOINT ["./docker_entrypoint"]
