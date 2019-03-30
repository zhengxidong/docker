
## lnp7.2_supervisord_dockerfile

基于最新版CentOS官方镜像

包含php, nginx, openssh server, crond, swoole服务。

### 获取镜像

* 远程获取镜像(推荐)
```js
$ docker pull zhengxidong/lnp7.2
$ git clone https://github.com/zhengxidong/docker.git
$ cd docker/lnp7.2_supervisord_dockerfile
```
* 构建镜像
```js
$ https://github.com/zhengxidong/docker.git
$ cd docker/lnp7.2_supervisord_dockerfile
$ ./build_lnp7.2_images.sh
```

### 运行容器

执行shell脚本
```js
./run_lnp7.2_container.sh
```
或
```js
docker run -d -p 80:80 --name lnp7.2 -v /home/html/itellyou.site:/usr/local/nginx/html/itellyou.site zhengxidong/lnp7.2:1.0
```
注意：`80端口是否已经被占用，如已经占用，请换一个映射端口`
参数说明
* -d 后台运行
* --name 容器名称
* -p 映射端口，容器80端口映射到宿主机80端口
* -v 挂载目录，`/home/html/itellyou.site`表示宿主机目录,`/usr/local/nginx/html/itellyou.site`表示容器内站点目录

容器内操作nginx、php，详细文档请查看[wiki](https://github.com/zhengxidong/docker-dev/wiki)


