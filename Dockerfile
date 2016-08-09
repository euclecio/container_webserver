FROM eminetto/apache-php7:latest
RUN apt-get update --fix-missing \
    && apt-get -y install default-jdk unzip sendmail \
    && apt-get -y install php7.0-pgsql php7.0-mcrypt php7.0-soap php7.0-zip \
    && phpdismod xdebug \
    && cd /tmp \
    && wget http://mirror.cc.columbia.edu/pub/software/eclipse/birt/downloads/drops/R-R1-4_5_0-201506092134/birt-runtime-4.5.0-20150609.zip  \
    && mv *.zip birt.zip \
    && unzip birt.zip \
    && mkdir -p /opt/birt \
    && mv birt-runtime* /opt/birt/runtime \
    && chmod +x /opt/birt/runtime/ReportEngine/genReport.sh
ENTRYPOINT [ "/usr/sbin/apache2" ]
CMD ["-D", "FOREGROUND"]
