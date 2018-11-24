说明
=================


## lnp7.2_supervisord_dockerfile

基于最新版CentOS官方镜像

包含php, nginx, openssh server, crond, swoole服务。

## 使用

### 拉取镜像
```js
docker pull zhengxidong/lnp7.2:1.0
```

### 创建目录(此目录为站点文件)

  在home目录下创建html目录

```js
mkdir /home/html
```

### 运行容器

```js
docker run -d -p 80:80 --name lnp7.2 -v /home/html:/usr/local/nginx/html zhengxidong/lnp7.2:1.0
```

* 宿主机站点目录
```js
/home/html
```
* 容器内站点目录

```js
/usr/local/nginx/html
```
### nginx命令

```
/usr/local/nginx/sbin/nginx -s reload|reopen|stop|quit  #重新加载配置|重启|停止|退出 nginx
/usr/local/nginx/sbin/nginx -t   #测试配置是否有语法错误

/usr/local/nginx/sbin/nginx [-?hvVtq] [-s signal] [-c filename] [-p prefix] [-g directives]

-?,-h           : 打开帮助信息
-v              : 显示版本信息并退出
-V              : 显示版本和配置选项信息，然后退出
-t              : 检测配置文件是否有语法错误，然后退出
-q              : 在检测配置文件期间屏蔽非错误信息
-s signal       : 给一个 nginx 主进程发送信号：stop（停止）, quit（退出）, reopen（重启）, reload（重新加载配置文件）
-p prefix       : 设置前缀路径（默认是：/usr/local/Cellar/nginx/1.2.6/）
-c filename     : 设置配置文件（默认是：/usr/local/etc/nginx/nginx.conf）
-g directives   : 设置配置文件外的全局指令
```
