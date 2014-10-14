# Dockerfile for One-Time Secret
# http://onetimesecret.com

FROM ubuntu

MAINTAINER Carla Souza <contact@carlasouza.com>

RUN apt-get update && apt-get install -y puppet
ADD init.pp /tmp/init.pp
RUN puppet apply /tmp/init.pp --trace

ADD config/config /etc/onetime/config
ADD config/redis.conf /etc/onetime/redis.conf
ADD config/fortunes /etc/onetime/fortunes
ADD config/Procfile.production /var/lib/onetime/

EXPOSE 7143

RUN cd /var/lib/onetime
ENTRYPOINT su -c '/usr/local/bin/foreman start -f /var/lib/onetime/Procfile.production' ots
