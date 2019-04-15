ARG OS_VER=latest


FROM centos:$OS_VER
MAINTAINER zxd <zhenxidog@163.com>


#root用户密码
ARG ROOT_PASSWORD=123456
#php版本
ARG PHP_VER=5.6.38
#nginx版本
ARG APACHE_VER=2.4.17
#hiredis版本
ARG HIREDIS_VER=0.13.3

#mysql sock目录
ARG MYSQL_SOCK_DIR=/var/lib/mysql

#映射配置文件
ADD ./etc /usr/src/etc


#基础环境配置
RUN yum install vim wget git net-tools -y \
    && yum install epel-release -y \
    && yum update -y \
    && yum -y install pcre pcre-devel zlib zlib-devel openssl openssl-devel libxml2 libxml2-devel libjpeg libjpeg-devel \
        libpng libpng-devel curl curl-devel libicu libicu-devel libmcrypt  libmcrypt-devel freetype freetype-devel \
        libmcrypt libmcrypt-devel autoconf gcc-c++ gcc make automake cmake ncurses-devel bison bison-devel\
    && yum install vixie-cron crontabs -y \
    && yum install python-setuptools -y \
    && easy_install supervisor \ 
    && yum install openssh-server -y \
    && echo PermitRootLogin  yes >> /etc/ssh/sshd_config \
    && echo PasswordAuthentication yes >> /etc/ssh/sshd_config \
    && echo RSAAuthentication yes >> etc/ssh/sshd_config \
    && sed -i "s/UseDNS yes/UseDNS no/" /etc/ssh/sshd_config \
    && echo "root:$ROOT_PASSWORD" | chpasswd \
    && ssh-keygen -t dsa -f /etc/ssh/ssh_host_rsa_key \
    && ssh-keygen -t rsa -f /etc/ssh/ssh_host_ecdsa_key \
    && ssh-keygen -t rsa -f /etc/ssh/ssh_host_ed25519_key \
    && yum clean all && rm -rf /var/cache/yum/*


#安装php
RUN cd /usr/src \
    && curl -o php.tar.gz http://php.net/get/php-${PHP_VER}.tar.gz/from/this/mirror -L \
    && mkdir php \
    && tar -xzvf php.tar.gz -C ./php --strip-components 1 \
    && cd php \
    && ./configure --prefix=/usr/local/php --with-config-file-path=/etc/php --enable-soap --enable-mbstring=all \
        --enable-sockets --enable-fpm --with-gd --with-freetype-dir=/usr/include/freetype2/freetype \
        --with-jpeg-dir=/usr/lib64 --with-zlib --with-iconv --enable-libxml --enable-xml  --enable-intl \
        --enable-zip --enable-pcntl --enable-bcmath --enable-maintainer-zts --with-curl --with-mcrypt --with-openssl \
        --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd \
    && make \
    && make install \
    && mkdir /etc/php \
    && cp /usr/src/php/php.ini-development /etc/php/php.ini \
    && echo $MYSQL_SOCK_DIR > /tmp/temp_mysql_sock_dir.txt && temp_mysql_sock_dir=$(sed "s/\//\\\\\//g" /tmp/temp_mysql_sock_dir.txt) && rm -rf /tmp/temp_mysql_sock_dir.txt \
    && sed -i "s/mysqli.default_socket =/mysqli.default_socket = ${temp_mysql_sock_dir}\/mysql.sock/" /etc/php/php.ini \
    && sed -i "s/pdo_mysql.default_socket=/pdo_mysql.default_socket = ${temp_mysql_sock_dir}\/mysql.sock/" /etc/php/php.ini \
    && cp /usr/src/php/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm \
    && chmod +x /etc/init.d/php-fpm \
    && cd /usr/local/php/etc \
    && cp php-fpm.conf.default php-fpm.conf \
    && sed -i "s/;daemonize = yes/daemonize = no/" php-fpm.conf \
    && sed -i "s/export PATH/PATH=\/usr\/local\/php\/bin:\$PATH\nexport PATH/" /etc/profile \
    && sed -i "s/export PATH/PATH=\/etc\/init.d:\$PATH\nexport PATH/" /etc/profile \
    && rm -rf /usr/src/php.tar.gz && rm -rf /usr/src/php 


# 安装apache需要的库

RUN cd /usr/src \
    && wget http://archive.apache.org/dist/apr/apr-1.4.5.tar.gz \
    && tar -zxf apr-1.4.5.tar.gz \
    && cd  apr-1.4.5 \
    && ./configure --prefix=/usr/local/apr \
    && make && make install 

RUN cd /usr/src \
    && wget http://archive.apache.org/dist/apr/apr-util-1.3.12.tar.gz \
    && tar -zxf apr-util-1.3.12.tar.gz \
    && cd apr-util-1.3.12 \
    #&& ./configure --prefix=/usr/local/apr-util --with-apr=/usr/local/apr/bin/apr-1-config --enable-utf8 \
    && ./configure --with-apr=/usr/local/apr --with-apr-util=/usr/local/apr-util \
    && make && make install

#安装apache
RUN cd /usr/src \
    #&& curl -o httpd.tar.gz http://apache.fayea.com/httpd/httpd-${APACHE_VER}.tar.gz -L \
    #&& mkdir apache && tar -xzvf httpd-2.tar.gz -C ./apache --strip-components 1 \
    && wget http://apache.fayea.com/httpd/httpd-2.4.37.tar.gz \
    && mkdir apache && tar -zxvf httpd-2.4.37.tar.gz -C ./apache --strip-components 1 \
    && cd apache \
    && ./configure --prefix=/usr/local/apache2 --enable-mods-shared=most --enable-so \
    && make && make install \
    #&& rm -rf /etc/apache \
    #&& rm -rf /usr/src/httpd-2.tar.gz && rm -rf /usr/src/apache 
    && sed -i 's/#ServerName www.example.com:80/ServerName localhost:80/g' /usr/local/apache2/conf/httpd.conf 

    # php redis扩展
    #&& /usr/local/php/bin/pecl install redis && echo "extension=redis.so" >> /etc/php/php.ini \
    # php memcache扩展
    #&& /usr/local/php/bin/pecl install memcache && echo "extension=memcache.so" >> /etc/php/php.ini 
    
#服务器基础设置
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' > /etc/timezonesource \
    && source /etc/profile \
    && echo [supervisord] > /etc/supervisord.conf \
    && echo nodaemon=true >> /etc/supervisord.conf \
    && echo user=root >> /etc/supervisord.conf \
    \
    && echo [program:sshd] >> /etc/supervisord.conf \
    && echo command=/usr/sbin/sshd -D >> /etc/supervisord.conf \
    \
    && echo [program:apache] >> /etc/supervisord.conf \
    && echo command=/usr/local/apache2/bin/httpd >> /etc/supervisord.conf \
    \
    && echo [program:php-fpm] >> /etc/supervisord.conf \
    && echo command=/usr/local/php/sbin/php-fpm >> /etc/supervisord.conf \
    \
    && echo [program:crond] >> /etc/supervisord.conf \
    && echo command=/usr/sbin/crond -n >> /etc/supervisord.conf


EXPOSE 80


CMD ["/usr/bin/supervisord"]
