#!/bin/bash

# -v /workplace/mosquitto/data/persistence_data/:/var/lib/mosquitto/ \
# -v /mosquitto/log/:/var/log/mosquitto/ \
# /usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf
#

docker stop dev_mqtt

docker rm dev_mqtt 
docker run -d --name dev_mqtt \
        --privileged=true \
        --restart=always \
        -v /home/docker/mqtt_dockerfile/mosquitto/etc/mosquitto/mosquitto.conf:/etc/mosquitto/mosquitto.conf \
	-v /home/docker/mqtt_dockerfile/mosquitto/password/pwfile:/etc/mosquitto/pwfile \
	-v /home/docker/mqtt_dockerfile/mosquitto/certs:/etc/mosquitto/certs \
	-v /home/docker/mqtt_dockerfile/mosquitto/log/mosquitto:/var/log/mosquitto \
        -p 33000:3000 \
        -p 18830:1883 \
	-p 18840:1884 \
        mosquitto:latest \
	/usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf 


