说明
=================


## lnp7.2_supervisord_dockerfile

基于最新版CentOS官方镜像

包含php, nginx, openssh server, crond, swoole服务。

## 使用

拉取镜像
```js
docker pull zhengxidong/lnp7.2
```

创建目录(此目录为站点文件)

  在home目录下创建html目录

```js
mkdir /home/html
```

运行容器

```js
docker run -d -p 80:80 --name lnp7.2 -v /home/html:/usr/local/nginx/html zhengxidong/lnp7.2:1.0
```



   
