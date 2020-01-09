# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    Dockerfile                                       .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: frfrey <frfrey@student.le-101.fr>          +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2019/11/19 22:06:29 by frfrey       #+#   ##    ##    #+#        #
#    Updated: 2020/01/09 17:35:29 by frfrey      ###    #+. /#+    ###.fr      #
#                                                          /                   #
#                                                         /                    #
# **************************************************************************** #

FROM  debian:buster-slim

LABEL maintainer="frfrey@student.le-101.fr"

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
&& apt-get clean -y

RUN apt-get clean \
	&& cd /var/www/html \
	&& wget https://fr.wordpress.org/latest-fr_FR.tar.gz \
	&& wget https://files.phpmyadmin.net/phpMyAdmin/4.9.4/phpMyAdmin-4.9.4-all-languages.tar.gz \
	&& tar -xvf latest-fr_FR.tar.gz \
	&& tar -xvf phpMyAdmin-4.9.4-all-languages.tar.gz \
	&& mv phpMyAdmin-4.9.4-all-languages phpmyadmin \
	&& rm phpMyAdmin-4.9.4-all-languages.tar.gz \
	&& rm latest-fr_FR.tar.gz

RUN rm /etc/nginx/sites-enabled/default \
	&& rm /var/www/html/index.nginx-debian.html

ADD ./srcs/default etc/nginx/sites-enabled/
ADD	./srcs/index.html /var/www/html/index.html

#CMD ["nginx", "-g", "daemon off;"]

EXPOSE 80 443 22 3306
VOLUME /app/logs
