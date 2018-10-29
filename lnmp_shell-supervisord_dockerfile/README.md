# docker-nginx-php7

## Description
Docker image support Nginx and PHP 7.1 depends on Centos 7. Composer and supervisor added, very convenient for Laravel projects.

## Services
- Nginx
- PHP-FPM

## PHP modules
Support most useful modules,

- gd
- mbstring
- bcmath
- process
- xml
- mysql
- postgresql
- mongodb
- opcache

## Usage

Run image

```
docker run -d --name nginx-php -p 8080:80  wwtg99/docker-nginx-php7:latest
```


Show service status

```
docker exec nginx-php supervisorctl status
```


Restart service

```
docker exec nginx-php supervisorctl restart all
```

## Volumes
- /data/www: default root directory for nginx server
- /data/conf/nginx: nginx server config directory, put your own server config here
- /data/conf/supervisord: supervisord program config directory, put your own deamon program config here
- /data/log: default log directory for nginx and supervisord
- /data/script: script.sh in the directory will be run before server started

Use your own server
```
docker run -d --name nginx-php -p 8080:80 -v /your_server_dir:/data/www -v /your_server_conf_dir:/data/conf/nginx  wwtg99/docker-nginx-php7:latest
```

Notice, if /data/conf/nginx/website.conf is not exists, there will create a default server config file. So use website.conf for your config file name, or there will be conflict for port 80.

## Environment
Set timezone: TZ

```
docker run -d --name nginx-php -p 8080:80 -e "TZ=Asia/Shanghai"  wwtg99/docker-nginx-php7:latest
```

Set server domain for default config: DOMAIN

```
docker run -d --name nginx-php -p 8080:80 -e "DOMAIN=test.com"  wwtg99/docker-nginx-php7:latest
```

Note, it is only useful for auto generated nginx config. 


## Scripts
If you have your own scripts to run before server started, add them to script.sh and put the script in the script volume. Note, timezone setting is disabled if you use your own script. 

```
docker run -d --name nginx-php -p 8080:80 -v /your_script_dir:/data/script wwtg99/docker-nginx-php7:latest
```
