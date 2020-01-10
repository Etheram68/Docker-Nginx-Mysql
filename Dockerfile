# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    Dockerfile                                       .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: frfrey <frfrey@student.le-101.fr>          +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2019/11/19 22:06:29 by frfrey       #+#   ##    ##    #+#        #
#    Updated: 2020/01/10 18:02:01 by frfrey      ###    #+. /#+    ###.fr      #
#                                                          /                   #
#                                                         /                    #
# **************************************************************************** #

FROM  debian:buster-slim

LABEL maintainer="Francois Frey <frfrey@student.le-101.fr>"

ENV NGINX_HOST /etc/nginx/sites-enabled/default
ENV NGINX_INDEX /var/www/html/index.html
ENV HOSTNAME /etc/hosts

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
	&& chmod 777 wordpress \
	&& chmod 777 phpmyadmin

RUN rm ${NGINX_HOST} \
	&& rm /var/www/html/index.nginx-debian.html

ADD ./srcs/default ${NGINX_HOST}
ADD	./srcs/index.html ${NGINX_INDEX}
COPY ./srcs/StartupScript.sh .
COPY ./srcs/init.sql .

RUN chmod +x StartupScript.sh

VOLUME /app/logs

EXPOSE 80 443 22 3306

CMD ["/bin/sh", "StartupScript.sh"]
