ARG OS_VER=latest

FROM centos:$OS_VER
MAINTAINER zxd <zhenxidog@163.com>

#root用户密码
ARG ROOT_PASSWORD=zxd19950808
#php版本,因为php版本间配置文件模板不相同，此处的版本号只能为大于7.0以上版本
ARG PHP_VER=7.2.8
#nginx版本
ARG NGINX_VER=1.15.2
#xhprof版本
ARG XHPROF_VER=1.2


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
    && yum install libgearman-devel -y \
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
    && ./configure \
	--prefix=/usr/local/php \
	--with-config-file-path=/etc/php --enable-soap --enable-mbstring=all \
        --enable-sockets --enable-fpm --with-gd --with-freetype-dir=/usr/include/freetype2/freetype \
        --with-jpeg-dir=/usr/lib64 --with-zlib --with-iconv --enable-libxml --enable-xml  --enable-intl \
        --enable-zip --enable-pcntl --enable-bcmath --enable-maintainer-zts --with-curl --with-openssl \
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
    && cp ./php-fpm.d/www.conf.default ./php-fpm.d/www.conf \
    && rm -rf /usr/src/php.tar.gz && rm -rf /usr/src/php 

# 安装php扩展
#php redis扩展
RUN /usr/local/php/bin/pecl install redis && echo "extension=redis.so" >> /etc/php/php.ini \
    #php xhprof扩展
    && cd /usr/src \
    && curl -o xhprof.tar.gz https://github.com/longxinH/xhprof/archive/v${XHPROF_VER}.tar.gz -L \
    && tar -xvf xhprof.tar.gz \
    && cd xhprof-${XHPROF_VER}/extension \
    && /usr/local/php/bin/phpize \
    && ./configure --with-php-config=/usr/local/php/bin/php-config --enable-xhprof && make && make install \
    && mkdir -p -m 777 /tmp/xhprof \
    && echo -e "[xhprof]\nextension = xhprof.so\nxhprof.output_dir = /tmp/xhprof" >> /etc/php/php.ini \
    && mkdir /var/tools \
    && cd /usr/src/xhprof-${XHPROF_VER} \
    && mv xhprof_html /var/tools/ \
    && mv xhprof_lib /usr/local/php/lib/php \
    && sed -i "s/dirname(__FILE__) . '\/..\/xhprof_lib'/'xhprof_lib'/" /var/tools/xhprof_html/index.php \
    && sed -i "s/dirname(__FILE__) . '\/..\/xhprof_lib'/'xhprof_lib'/" /var/tools/xhprof_html/callgraph.php \
    && sed -i "s/dirname(__FILE__) . '\/..\/xhprof_lib'/'xhprof_lib'/" /var/tools/xhprof_html/typeahead.php \
    && rm -rf /usr/src/xhprof-${XHPROF_VER} && rm -rf /usr/src/xhprof.tar.gz 

#安装nginx
RUN cd /usr/src \
    && curl -o nginx.tar.gz http://nginx.org/download/nginx-${NGINX_VER}.tar.gz -L \
    && mkdir nginx && tar -xzvf nginx.tar.gz -C ./nginx --strip-components 1 \
    && cd nginx \
    && ./configure \
 	--prefix=/usr/local/nginx \
	--conf-path=/etc/nginx/nginx.conf \
	--error-log-path=/var/log/nginx/error.log \
        --http-log-path=/var/log/nginx/access.log \
	--pid-path=/var/run/nginx.pid --lock-path=/var/lock/nginx.lock \
        --user=nginx --group=nginx --with-http_ssl_module --with-http_flv_module --with-http_stub_status_module \
        --with-http_gzip_static_module --http-client-body-temp-path=/tmp/nginx/client/ \
        --http-proxy-temp-path=/tmp/nginx/proxy/ \
        --http-fastcgi-temp-path=/tmp/nginx/fcgi/ \
        --with-pcre --with-http_dav_module \
    && make && make install \
    && useradd nginx \
    && mkdir -p -m 777 /tmp/nginx \
    && echo "#!/bin/sh" > /etc/init.d/nginx \
    && echo "#description: Nginx web server." >> /etc/init.d/nginx \
    && echo -e "case \$1 in \n\
            restart): \n\
                /usr/local/nginx/sbin/nginx -s reload \n\
                ;; \n\
            stop): \n\
                /usr/local/nginx/sbin/nginx -s stop \n\
                ;; \n\
            *): \n\
                /usr/local/nginx/sbin/nginx \n\
                ;; \n\
        esac \n" >> /etc/init.d/nginx \
    && chmod +x /etc/init.d/nginx \
    #&& sed -i "3a daemon off;" /etc/nginx/nginx.conf \
    #&& sed -i "s/index  index.html index.htm;/index  index.php index.html index.htm;/" /etc/nginx/nginx.conf \
    #&& sed -i "s/# pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000/location ~ \.php\$ { \nfastcgi_pass 127.0.0.1:9000;\nfastcgi_index  index.php;\nfastcgi_param  SCRIPT_FILENAME  \$document_root\$fastcgi_script_name;\ninclude fastcgi_params;\n }/" /etc/nginx/nginx.conf \
    && echo "<?php phpinfo()?>" > /usr/local/nginx/html/index.php \
    && rm -rf /etc/nginx && cp -rf /usr/src/etc/nginx /etc/nginx \
    && mkdir -m 777 -p /var/log/nginx \
    && rm -rf /usr/src/nginx.tar.gz && rm -rf /usr/src/nginx 


#服务器基础设置
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' > /etc/timezonesource \
    && source /etc/profile \
    &&echo [supervisord] > /etc/supervisord.conf \
    && echo nodaemon=true >> /etc/supervisord.conf \
    && echo user=root >> /etc/supervisord.conf \
    \
    && echo [program:sshd] >> /etc/supervisord.conf \
    && echo command=/usr/sbin/sshd -D >> /etc/supervisord.conf \
    \
    && echo [program:nginx] >> /etc/supervisord.conf \
    && echo command=/usr/local/nginx/sbin/nginx  >> /etc/supervisord.conf \
    \
    && echo [program:php-fpm] >> /etc/supervisord.conf \
    && echo command=/usr/local/php/sbin/php-fpm >> /etc/supervisord.conf \
    \
    && echo [program:crond] >> /etc/supervisord.conf \
    && echo command=/usr/sbin/crond -n >> /etc/supervisord.conf


EXPOSE 80
CMD ["/usr/bin/supervisord"]
