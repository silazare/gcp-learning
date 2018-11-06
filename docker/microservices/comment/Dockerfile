FROM andrius/alpine-ruby:3.3
RUN apk add --no-cache --update ruby-dev build-base

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/

RUN bundle install \
    && gem cleanup \
    && apk del ruby-dev build-base \
    && rm -rf /usr/lib/ruby/gems/*/cache/* \
       /var/cache/apk/* \
       /tmp/* \
       /var/tmp/*

ADD . $APP_HOME

ENV COMMENT_DATABASE_HOST=comment_db \
    COMMENT_DATABASE=comments

CMD ["puma"]
