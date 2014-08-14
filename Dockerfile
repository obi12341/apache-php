FROM ubuntu

RUN apt-get update && apt-get install -y apache2 \
        libapache2-mod-php5 \
        php5-curl \
        php5-gd \
        php5-mysql \
	php5-apcu
RUN /usr/sbin/a2enmod rewrite

#RUN sed -i "s/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\//g" /etc/apache2/sites-enabled/000-default.conf
RUN sed -i "s/max_execution_time = 30/max_execution_time = 240/g" /etc/php5/cli/php.ini
RUN sed -i "s/max_execution_time = 30/max_execution_time = 240/g" /etc/php5/apache2/php.ini
RUN sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 20M/g" /etc/php5/cli/php.ini
RUN sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 20M/g" /etc/php5/apache2/php.ini
RUN sed -i "s/post_max_size = 8M/post_max_size = 20M/g" /etc/php5/cli/php.ini
RUN sed -i "s/post_max_size = 8M/post_max_size = 20M/g" /etc/php5/apache2/php.ini
RUN sed -i "s/;date.timezone =/date.timezone = \"Europe\/Berlin\"/g" /etc/php5/cli/php.ini
RUN sed -i "s/;date.timezone =/date.timezone = \"Europe\/Berlin\"/g" /etc/php5/apache2/php.ini
ADD vhost.conf /etc/apache2/sites-available/vhost.conf
RUN a2dissite 000-default
RUN a2ensite vhost

EXPOSE 80
CMD ["/usr/sbin/apachectl", "-D FOREGROUND"]
