# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    Dockerfile                                       .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: frfrey <frfrey@student.le-101.fr>          +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2019/11/19 22:06:29 by frfrey       #+#   ##    ##    #+#        #
#    Updated: 2020/01/10 16:37:37 by frfrey      ###    #+. /#+    ###.fr      #
#                                                          /                   #
#                                                         /                    #
# **************************************************************************** #

FROM  debian:buster-slim

LABEL maintainer="Francois Frey <frfrey@student.le-101.fr>"

ENV nginx_host /etc/nginx/sites-enabled/default
ENV nginx_index /var/www/html/index.html

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
	&& chmod 777 wordpress

RUN rm ${nginx_host} \
	&& rm /var/www/html/index.nginx-debian.html

ADD ./srcs/default ${nginx_host}
ADD	./srcs/index.html ${nginx_index}
COPY ./srcs/StartupScript.sh .
COPY ./srcs/init.sql .

RUN chmod +x StartupScript.sh

VOLUME /app/logs

EXPOSE 80 443 22 3306

CMD ["/bin/sh", "StartupScript.sh"]
