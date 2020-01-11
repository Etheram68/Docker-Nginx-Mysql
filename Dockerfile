# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    Dockerfile                                       .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: frfrey <frfrey@student.le-101.fr>          +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2019/11/19 22:06:29 by frfrey       #+#   ##    ##    #+#        #
#    Updated: 2020/01/11 14:38:16 by frfrey      ###    #+. /#+    ###.fr      #
#                                                          /                   #
#                                                         /                    #
# **************************************************************************** #

FROM  debian:buster-slim

LABEL maintainer="Francois Frey <frfrey@student.le-101.fr>"

ENV NGINX_HOST /etc/nginx/sites-available/default
ENV NGINX_INDEX /var/www/html/index.html
ENV ENV off

RUN apt-get update \
&& apt-get -y upgrade \
&& apt-get install -y \
	--no-install-recommends --no-install-suggests -y ca-certificates libssl1.1 \
	nginx \
	default-mysql-server \
	default-mysql-client \
	php \
	php-fpm \
	php-cli \
	php-curl \
	php-mysql \
	php-gd \
	php-mbstring \
	wget \
	vim \
&& apt-get clean -y \
&& apt-get update \
&& apt-get -y upgrade

RUN apt-get clean \
	&& cd /var/www/html \
	&& wget https://fr.wordpress.org/latest-fr_FR.tar.gz \
	&& wget https://files.phpmyadmin.net/phpMyAdmin/4.9.4/phpMyAdmin-4.9.4-all-languages.tar.gz \
	&& tar -xvf latest-fr_FR.tar.gz \
	&& tar -xvf phpMyAdmin-4.9.4-all-languages.tar.gz \
	&& mv phpMyAdmin-4.9.4-all-languages phpmyadmin \
	&& rm phpMyAdmin-4.9.4-all-languages.tar.gz \
	&& rm latest-fr_FR.tar.gz \
	&& chmod 777 -R wordpress \
	&& chmod 777 -R phpmyadmin

RUN rm ${NGINX_HOST} \
	&& rm /var/www/html/index.nginx-debian.html\
	&& rm /var/www/html/phpmyadmin/config.sample.inc.php

ADD ./srcs/nginx/default ${NGINX_HOST}
ADD	./srcs/index.html ${NGINX_INDEX}
ADD ./srcs/nginx/nginx-selfsigned.key /etc/ssl/private/nginx-selfsigned.key
ADD ./srcs/nginx/nginx-selfsigned.crt /etc/ssl/certs/nginx-selfsigned.crt
ADD ./srcs/nginx/dhparam.pem /etc/nginx/dhparam.pem
ADD ./srcs/nginx/self-signed.conf /etc/nginx/snippets/self-signed.conf
ADD ./srcs/nginx/ssl-params.conf /etc/nginx/snippets/ssl-params.conf
ADD ./srcs/config.inc.php /var/www/html/phpmyadmin/config.inc.php
COPY ./srcs/StartupScript.sh .
COPY ./srcs/init.sql .

RUN chmod +x StartupScript.sh

VOLUME /app/logs

EXPOSE 80 443 22 3306

CMD ["/bin/sh", "StartupScript.sh"]
