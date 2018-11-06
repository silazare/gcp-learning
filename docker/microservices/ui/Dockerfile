FROM andrius/alpine-ruby:3.3
RUN apk add --no-cache --update ruby-dev build-base

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/

RUN bundle install \
    && gem cleanup \
    && apk del build-base ruby-dev \
    && rm -rf /usr/lib/ruby/gems/*/cache/* \
       /var/cache/apk/* \
       /tmp/* \
       /var/tmp/*

ADD . $APP_HOME
ENV POST_SERVICE_HOST=post \
    POST_SERVICE_PORT=5000 \
    COMMENT_SERVICE_HOST=comment \
    COMMENT_SERVICE_PORT=9292

CMD ["puma"]
