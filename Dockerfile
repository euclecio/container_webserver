FROM eminetto/apache-php7:latest

RUN  locale-gen pt_BR.utf8 && locale-gen en_US.utf8

RUN apt-get update --fix-missing \
    && apt-get -y install unzip sendmail \
    && apt-get -y install php7.0-pgsql php7.0-mcrypt php7.0-soap php7.0-zip \
    && phpdismod xdebug
    


ENTRYPOINT [ "/usr/sbin/apache2" ]
CMD ["-D", "FOREGROUND"]
