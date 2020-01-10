# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    StartupScript.sh                                 .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: frfrey <frfrey@student.le-101.fr>          +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2020/01/10 14:31:25 by frfrey       #+#   ##    ##    #+#        #
#    Updated: 2020/01/10 16:30:04 by frfrey      ###    #+. /#+    ###.fr      #
#                                                          /                   #
#                                                         /                    #
# **************************************************************************** #

#!/bin/sh

#Start all service on my docker
service nginx start
service php7.3-fpm start
service mysql start

#See if the container is already launched
CONTAINER_ALREADY_STARTED="CONTAINER_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e $CONTAINER_ALREADY_STARTED ]; then
    touch $CONTAINER_ALREADY_STARTED
    echo "-- First container startup --"

	#Create a mysql user
	mysql < init.sql

	#Restart mysql service
	service mysql --full-restart
else
    echo "-- Not first container startup --"
fi

nginx -g "daemon off;"

while [ true ]
do true = true
done
