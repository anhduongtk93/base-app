
# Use the official lightweight Ruby image.
# https://hub.docker.com/_/ruby
FROM ruby:2.7.4

ARG RAILS_ENV_ARG

ENV RAILS_ENV=${RAILS_ENV_ARG:-production}
#ENV NODE_ENV=${RAILS_ENV:-production}
#ENV RACK_ENV=${RAILS_ENV:-production}

RUN mkdir /app
WORKDIR /app
COPY  Gemfile Gemfile.lock /app/

RUN gem uninstall bundler
RUN gem install bundler -v 2.2.17 --no-document
RUN bundle install
#RUN bundle install -j $(grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}')
COPY . /app/

#RUN bundle exec rake assets:precompile

COPY docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["bin/docker-entrypoint"]