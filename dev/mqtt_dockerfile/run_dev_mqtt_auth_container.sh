#!/bin/bash

docker run -d --name sit_mqtt_auth \
        --privileged=true \
        --restart=always \
        -v /workplace/mosquitto_auth/data/persistence_data/:/var/lib/mosquitto/ \
        -v /workplace/mosquitto_auth/log/:/var/log/mosquitto/ \
        -v /workplace/mosquitto_auth/etc/mosquitto/mosquitto.conf:/etc/mosquitto/mosquitto.conf \
        -v /workplace/mosquitto_auth/etc/mosquitto/mdc_pwd:/etc/mosquitto/mdc_pwd \
        -v /workplace/mosquitto_auth/etc/mosquitto/mdc_acl:/etc/mosquitto/mdc_acl \
        -p 33001:3000 \
        -p 18840:1883 \
        mdc/mosquitto:latest \
        /usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf


