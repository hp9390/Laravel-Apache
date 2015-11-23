FROM php:5.6.15-apache
RUN  phpDeps='libxml2 \
              libcurl4-openssl-dev \
              php5-dev \
              php5-cli \
              php5-mysql \
              php5-pgsql \
              php5-mcrypt \
              php5-curl \
              php5-json \
              php5-gd \
              php-pear \
              libapache2-mod-php5 \
              libapache2-mod-php5filter \
              php5-cgi \
              php5-fpm \
              php5 \
              php-apc' \
  && apt-get update -qq \
  && apt-get install -y -qq $phpDeps \
  && pecl install mongo \
  && apt-get clean -qq \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && apt-get purge -y --auto-remove $buildDeps \
  && echo "extension=mongo.so" > /etc/php5/mods-available/mongo.ini \
  && a2enmod rewrite \
  && php5enmod mcrypt mongo \
