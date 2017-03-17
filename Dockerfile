FROM debian:latest

ENV LC_ALL=C
ENV LANG en_US.UTF-8
ENV LANG_ALL en_US.UTF-8
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

RUN apt-get update \
    && apt-get -y install wget apt-transport-https \
    && wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ jessie main" > /etc/apt/sources.list.d/php.list \
    && apt-get update
RUN apt-get -y install php7.1 \
    php7.1-bcmath \
    php7.1-cli \
    php7.1-curl \
    php7.1-dev \
    php7.1-gd \
    php7.1-intl \
    php7.1-json \
    php7.1-mbstring \
    php7.1-mcrypt \
    php7.1-mysql \
    php7.1-pgsql \
    php7.1-phpdbg \
    php7.1-soap \
    php7.1-sqlite3 \
    php7.1-zip \
    php-apcu \
    php-apcu-bc \
    php-imagick \
    php-memcached \
    php-pear \
    php-xdebug \
    apache2 \
    libapache2-mod-php7.1 \
    autoconf \
    curl \
    git-core \
    imagemagick \
    libcurl4-openssl-dev \
    libcurl4-openssl-dev \
    libpcre3-dev \
    libsasl2-dev \
    libsasl2-dev \
    libssl-dev \
    openssl \
    pkg-config \
    sendmail \
    unzip \
    locales
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen \
    && a2enmod headers \
    && a2enmod rewrite \
    && phpdismod xdebug \
    mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR \
    ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.lo
RUN apt-get -y install supervisor sudo cron && touch /var/log/cron.log

VOLUME [ "/var/www/html" ]
WORKDIR /var/www/html

EXPOSE 80

ENTRYPOINT [ "/usr/sbin/apache2" ]
CMD ["-D", "FOREGROUND"]
