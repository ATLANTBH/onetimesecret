#!/bin/bash

secret=$(dd if=/dev/urandom bs=20 count=1 | md5sum | awk '{print $1}')
sed -i "s/# requirepass/requirepass/g" /etc/onetime/redis.conf
sed -i "s/CHANGEME/$secret/g" /etc/onetime/redis.conf /etc/onetime/config

redis-server /etc/onetime/redis.conf &
bundle exec thin -e dev -R config.ru -p 7143 start