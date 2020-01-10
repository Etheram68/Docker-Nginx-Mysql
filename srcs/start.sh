# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    start.sh                                         .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: frfrey <frfrey@student.le-101.fr>          +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2020/01/10 11:30:59 by frfrey       #+#   ##    ##    #+#        #
#    Updated: 2020/01/10 12:15:34 by frfrey      ###    #+. /#+    ###.fr      #
#                                                          /                   #
#                                                         /                    #
# **************************************************************************** #

#!/bin/sh

#Start all service on my docker
service nginx start
service php7.3-fpm start
service mysql start

#Create a mysql user
mysql < init.sql

#Restart mysql service
service mysql --full-restart
