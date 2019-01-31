#!/bin/bash

# -v /workplace/mosquitto/data/persistence_data/:/var/lib/mosquitto/ \
# -v /mosquitto/log/:/var/log/mosquitto/ \
# /usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf
# 
docker run -d --name dev_mqtt \
        --privileged=true \
        --restart=always \
        -v /home/docker/mqtt_dockerfile/mosquitto/etc/mosquitto/mosquitto.conf:/etc/mosquitto/mosquitto.conf \
	-v /home/docker/mqtt_dockerfile/mosquitto/password/pwfile:/etc/mosquitto/pwfile \
        -p 33000:3000 \
        -p 18830:1883 \
        mosquitto:latest \
	/usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf 


