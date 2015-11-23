FROM php:5.6.15-apache
RUN  phpDeps='libxml2 \
              libcurl4-openssl-dev \
              libapache2-mod-php5 \
              php5-dev \
              php5-cli \
              php5-mysql \
              php5-pgsql \
              php5-mcrypt \
              php5-curl \
              php5-json \
              php5-gd \
              php-pear \
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
  && sed -i -e "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini \
  && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
