简介
=================
Docker 是一个开源的应用容器引擎，让开发者可以打包他们的应用以及依赖包到一个可移植的容器中，然后发布到任何流行的 Linux 机器上，也可以实现虚拟化。容器是完全使用沙箱机制，相互之间不会有任何接口。

目前 Docker 有两套版本，一套是早期的 Docker 程序，版本号为 v1.*，CentOS 系统使用 yum 安装的默认就是这个版本。另一套是后期发展的整个 Docker 生态，版本号是 v17.*，分为社区版及企业版。本文以下使用 Linux CentOS 7 系统（其他 Linux 系统的使用方式类似），Docker 社区版 Docker-CE v17.12，Docker-CE 各个系统的安装方式请参考 [Docker 安装文档](https://link.zhihu.com/?target=https%3A//docs.docker.com/install/)。

**在此说明下，build过程中的安装方式有三种：**

* 1、通过yum安装方式进行安装

* 2、通过curl下载源码包编译安装

* 3、手动下载好源码包，build的过程中，将源码包CP到镜像中进行编译安装（推荐这种方式，因为以上两种需要更新一些yum源或者下载一些包，网络不好情况下，难以build出一个镜像）

**目录名格式:**

php环境基本服务简称_其它服务简称_服务启动方式名称_dockerfile

**服务启动方式:**

`注意：`这里所说的服务启动方式是指容器启动后，容器内的服务以什么方式自动启动。

使用`-`隔开表示脚本配合进程服务启动。

## 目录结构

~~~
docker-dev  仓库
├─lnmp7.2_rgmnpx_supervisord_dockerfile   php7.2相关文件
│  ├─data               数据存储
|  |  └─log
│  ├─etc                ngixn配置文件目录
│  │  └─nginx           
│  ├─Dockerfile         Dockerfile文件
│  ├─build_lnmp_images.sh    创建新镜像脚本
│  └─run_lnmp_container.sh   创建新容器脚本

~~~

## 目录说明
### [lnmp7.2_rgmnpx_supervisord_dockerfile](https://github.com/zhengxidong/docker-dev/tree/master/lnmp7.2_rgmnpx_supervisord_dockerfile)

基于最新版CentOS官方镜像

包含php, nginx, mysql, reids, openssh server, go, crond, swoole, mongodb, node.js, phpmyadmin, phpredisadmin, xhprof等服务。

版本：

* php7.2.8
* nginx1.15.2
* mysql5.7.23
* redis4.0.11
* openssh
* go1.10.3
* crond
* swoole4.0.4
* mongodb4.0.1
* node8.11.4
* phpmyadmin4.7.6
* phpredisadmin0.13.3
* xhprof1.2

服务启动方式

   supervisord启动

### [lnp7.2_supervisord_dockerfile](https://github.com/zhengxidong/docker-dev/tree/master/lnp7.2_supervisord_dockerfile)

基于最新版CentOS官方镜像
包含php,nginx,crond,swoole服务

版本：

* php7.2.8
* nginx1.15.2
* swoole4.0.4

服务启动方式

 supervisord启动


### [lnmp7.2_shell-supervisord_dockerfile](https://github.com/zhengxidong/docker-dev/tree/master/lnmp7.2_shell-supervisord_dockerfile)


基于最新版CentOS官方镜像
包含php，nginx，mysql，服务

版本：

* php7
* nginx
* mysql

服务启动方式

 shell配合supervisord启动   

### [lnp5.6_supervisord_dockerfile](https://github.com/zhengxidong/docker/tree/master/lnp5.6_supervisord_dockerfile)

基于最新版CentOS官方镜像
包含php，nginx服务

版本：

* php5.6
* nginx1.15.2

服务启动方式

  supervisord启动   
