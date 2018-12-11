FROM ruby:1.9

RUN apt-get update && apt-get -y install ntp libyaml-dev libevent-dev zlib1g zlib1g-dev openssl libssl-dev libxml2 libreadline-gplv2-dev redis-server

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install -j 8 --frozen --deployment --without=dev

RUN mkdir -p /var/log/onetime /var/run/onetime /var/lib/onetime /etc/onetime

COPY . .

RUN cp -R etc/* /etc/onetime/

EXPOSE 7143
CMD /app/init.sh