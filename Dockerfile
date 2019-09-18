FROM nextcloud:latest

RUN a2enmod ssl
COPY ./ssl.conf /etc/apache2/sites-available
COPY ./nextcloud-cron /etc/cron.d/
RUN ln -s /etc/apache2/sites-available/ssl.conf /etc/apache2/sites-enabled/ssl.conf
COPY ./openssl.conf /tmp
RUN openssl genrsa 2048 > /etc/ssl/private/nextcloud.key
RUN chmod 400 /etc/ssl/private/nextcloud.key
RUN openssl req -new -x509 -nodes -sha256 -days 365 -config /tmp/openssl.conf -key /etc/ssl/private/nextcloud.key -out /etc/ssl/certs/nextcloud.cert
RUN rm /tmp/openssl.conf
