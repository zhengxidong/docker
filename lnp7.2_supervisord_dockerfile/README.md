
## lnp7.2_supervisord_dockerfile

基于最新版CentOS官方镜像

包含php, nginx, openssh server, crond, swoole服务。

## 如何通过镜像运行一个开发容器

### 可以拉取镜像或自己build一个镜像

拉取镜像
```js
docker pull zhengxidong/lnp7.2:1.0
```

### 创建目录(此目录为站点文件)

  在home目录下创建站点目录

```js
mkdir /home/html/itellyou.site
```

### 运行容器

```js
docker run -d -p 80:80 --name lnp7.2 -v /home/html:/usr/local/nginx/html zhengxidong/lnp7.2:1.0
```

#### 宿主机

1. 站点目录(可自定义)
```js
/home/html/itellyou.site
```
## 容器内基本操作

### 如何操作nginx
1. 站点根目录
```js
/usr/local/nginx/html
```
2. 配置文件目录
```js
/etc/nginx
```
3. 日志目录

 ```js
 /var/log/nginx
 ```

### 如何操作php

1. php配置文件目录
```js
/etc/php
```
详细文档请查看[wiki](https://github.com/zhengxidong/docker-dev/wiki)

