简介
=================

**目录格式:**
php环境基本服务简称_其它服务简称_服务启动方式名称_dockerfile

**服务启动方式:**
使用`-`隔开表示脚本配合进程服务启动


## 目录说明
### lnmp_rgmnpx_supervisord_dockerfile

基于最新版CentOS官方镜像

包含php, nginx, mysql, reids, openssh server, go, crond, swoole, mongodb, node.js, phpmyadmin, phpredisadmin, xhprof等服务。

版本：

* php7
* nginx
* mysql
* redis
* openssh
* go
* crond
* swoole
* mongodb
* node
* phpmyadmin
* phpredisadmin
* xhprof

服务启动方式

   supervisord启动

### lnp_supervisord_dockerfile

基于最新版CentOS官方镜像
包含php,nginx,crond,swoole服务

版本：

* php7
* nginx
* swoole

服务启动方式

 supervisord启动


### lnmp_shell-supervisord_dockerfile


基于最新版CentOS官方镜像
包含php，nginx，mysql，服务

版本：

* php7
* nginx
* mysql

服务启动方式

 shell配合supervisord启动   
