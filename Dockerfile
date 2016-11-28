FROM ubuntu:latest

ENV LANG en_US.UTF-8
ENV LANG_ALL en_US.UTF-8


RUN apt-get update \
    && apt-get install -y software-properties-common language-pack-en-base \
    && add-apt-repository -y ppa:ondrej/php \
    && apt-get update \
    && apt-get install -y
        apache2 \
        autoconf \
        curl \
        git-core \
        imagemagick \
        libapache2-mod-php7.0 \
        libcurl4-openssl-dev \
        libcurl4-openssl-dev \
        libpcre3-dev \
        libsasl2-dev \
        libsasl2-dev \
        libssl-dev \
        libssl-dev \
        libsslcommon2-dev \
        openssl \
        php-apcu \
        php-apcu-bc \
        php-imagick \
        php-memcached \
        php-pear \
        php-xdebug \
        php7.0 \
        php7.0-bcmath \
        php7.0-cli \
        php7.0-curl \
        php7.0-dev \
        php7.0-gd \
        php7.0-intl \
        php7.0-json \
        php7.0-mbstring \
        php7.0-mcrypt \
        php7.0-mysql \
        php7.0-pgsql \
        php7.0-phpdbg \
        php7.0-soap \
        php7.0-sqlite3 \
        php7.0-zip \
        pkg-config \
        sendmail \
        unzip \
        vim \
        wget \
    && a2enmod headers \
    && a2enmod rewrite \
    && phpdismod xdebug

RUN locale-gen pt_BR.utf8 && locale-gen en_US.utf8

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2


RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR

#to dump apache erros on the stdout
RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log

VOLUME [ "/var/www/html" ]
WORKDIR /var/www/html

EXPOSE 80

ENTRYPOINT [ "/usr/sbin/apache2" ]
CMD ["-D", "FOREGROUND"]

