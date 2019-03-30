
## lnp7.2_supervisord_dockerfile

基于最新版CentOS官方镜像

包含php, nginx, openssh server, crond, swoole服务。

## 如何通过镜像运行一个开发容器

### 获取镜像

* 远程获取镜像(推荐)
```js
docker pull zhengxidong/lnp7.2
cd docker/lnp7.2_supervisord_dockerfile
```
* 构建镜像
```js
cd docker/lnp7.2_supervisord_dockerfile
./build_lnp7.2_images.sh
```

### 运行容器

执行shell脚本
```js
./run_lnp7.2_container.sh
```
或
```js
docker run -d -p 80:80 --name lnp7.2 -v /home/html:/usr/local/nginx/html zhengxidong/lnp7.2:1.0
```
注意：`80端口是否已经被占用，如已经占用，请换一个映射端口`

容器内操作nginx、php，详细文档请查看[wiki](https://github.com/zhengxidong/docker-dev/wiki)


