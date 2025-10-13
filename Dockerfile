FROM ubuntu:20.04

ENV GEM_HOME="/srv/gems" \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

RUN apt-get update && \
    DEBIAN_FRONTEND='noninteractive' apt-get install -y \
      apache2

RUN DEBIAN_FRONTEND='noninteractive' apt-get install -y \
  lua5.2 \
  lua5.2-sec \
  lua-socket \
  lua-posix

RUN a2enmod cgi && \
    a2enmod lua && \
    a2enmod headers && \
    a2enmod rewrite

RUN apt-get update && DEBIAN_FRONTEND='noninteractive' apt-get install -y \
  vim
    
RUN echo "ServerName apache-lua.local" > /etc/apache2/conf-enabled/servername.conf

RUN DEBIAN_FRONTEND='noninteractive' apt-get install -y curl

COPY _docker/000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY scripts/attic_filter.lua /etc/apache2/conf-enabled/attic_filter.lua
COPY _docker/wrapper.lua /etc/apache2/conf-enabled/wrapper.lua

EXPOSE 80

WORKDIR /var/www

CMD ["apache2ctl", "-DFOREGROUND"]