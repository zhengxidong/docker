# docker版本的mosquitto,支持websockets,mqtt协议
FROM centos:latest

MAINTAINER zxd <>

WORKDIR /root/

# 自安装库
COPY ./libwebsockets-v1.5-stable.tar.gz /root/libwebsockets-v1.5-stable.tar.gz
COPY ./mosquitto-1.4.12.websockets.tar.gz /root/mosquitto-1.4.12.websockets.tar.gz

# 安装依赖库
RUN yum install -y gcc-c++
RUN yum install -y openssl-devel c-ares-devel libuuid-devel
RUN yum install -y make cmake
RUN tar zxvf libwebsockets-v1.5-stable.tar.gz && cd libwebsockets-v1.5-stable && mkdir build && cd build && cmake .. && make && make install && cd /root/

# 在改变了config.mk的prefix前提下,不需要用软链接
RUN ln -sf /usr/local/lib/libwebsockets.so.5 /usr/lib64/libwebsockets.so.5
RUN tar zxvf mosquitto-1.4.12.websockets.tar.gz && cd mosquitto-1.4.12 && make && make install && adduser mosquitto && cp /etc/mosquitto/mosquitto.conf.example /etc/mosquitto/mosquitto.conf

# 移除不需要的库
RUN cd /root/
RUN yum remove -y openssl-devel c-ares-devel libuuid-devel gcc-c++ make cmake
RUN rm -rf libwebsockets* mosquitto-1.4.12*

VOLUME ["/var/lib/mosquitto","/var/log/mosquitto","/etc/mosquitto"]

EXPOSE 1883 1884 3000

CMD ["/usr/sbin/init"]

#CMD ["/usr/sbin/mosquitto","-c","/etc/mosquitto/mosquitto.conf"]

