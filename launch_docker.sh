# **************************************************************************** #
#                                                           LE - /             #
#                                                               /              #
#    launch_docker.sh                                 .::    .:/ .      .::    #
#                                                  +:+:+   +:    +:  +:+:+     #
#    By: frfrey <frfrey@student.le-101.fr>          +:+   +:    +:    +:+      #
#                                                  #+#   #+    #+    #+#       #
#    Created: 2020/01/10 14:48:06 by frfrey       #+#   ##    ##    #+#        #
#    Updated: 2020/01/10 16:31:00 by frfrey      ###    #+. /#+    ###.fr      #
#                                                          /                   #
#                                                         /                    #
# **************************************************************************** #

#!/bin/sh

docker build -t server .
docker run -itd -p 80:80 -p 3306:3306 -p 443:443 --name=server server:latest
docker exec -ti server bash
