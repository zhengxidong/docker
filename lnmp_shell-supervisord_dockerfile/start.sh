#!/bin/sh
#########################################################################
# File Name: start.sh
# Author: wwtg99
# Email:  wwtg99@126.com
# Version:
# Created Time: 2018/02/12
#########################################################################

# add default nginx server config
Nginx_Conf=/data/conf/nginx
DATA_DIR=/data/www

set -e
chown -R www:www $DATA_DIR

if [[ ! -f "${Nginx_Conf}/website.conf" ]]; then

	echo 'Create test server config file.'

	if [ "$DOMAIN" = "" ]; then
		DOMAIN='localhost'
	fi

	cat > ${Nginx_Conf}/website.conf << EOF
server {
   listen 80;
   server_name $DOMAIN;
   
   root   $DATA_DIR;
   index  index.php index.html index.htm;

   location / {
       try_files \$uri \$uri/ /index.php?\$args;
   }

   location ~ \.php$ {
       root           /data/www;
       fastcgi_pass   127.0.0.1:9000;
       fastcgi_index  index.php;
       fastcgi_param  SCRIPT_FILENAME  /\$document_root\$fastcgi_script_name;
       include        fastcgi_params;
   }
}
EOF
fi

# run user script
if [[ -f "/data/script/script.sh" ]]; then
  source /data/script/script.sh
fi

/usr/bin/supervisord -n -c /etc/supervisord.conf
