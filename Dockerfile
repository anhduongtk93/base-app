
# Use the official lightweight Ruby image.
# https://hub.docker.com/_/ruby
FROM ruby:2.7.4

# Install production dependencies.
#WORKDIR /usr/src/app
#COPY Gemfile Gemfile.lock ./
#ENV BUNDLE_FROZEN=true
#RUN gem uninstall bundler
#RUN gem install bundler -v 2.2.17 --no-document
## Copy local code to the container image.
#COPY . ./
#
## Run the web service on container startup.
#CMD ["ruby", "./app.rb"]

# ------------------------------
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