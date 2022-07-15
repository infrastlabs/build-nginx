# 

- conf1, nginx 编译参数详解(运维不得不看) – 运维生存时间 http://www.ttlsa.com/nginx/nginx-configure-descriptions/
- conf2, nginx配置编译选项_netlai的博客-CSDN博客_nginx编译选项 https://blog.csdn.net/netlai/article/details/80016712
- Linux绿色版Nginx_怪人yo的博客-CSDN博客_nginx 绿色版 https://blog.csdn.net/weixin_43715518/article/details/122986204

## old1

```bash
[root@5c53533b458e rootfs]# cd bin/
[root@5c53533b458e bin]# ./nginx -V
nginx version: nginx/1.23.0
built by gcc 10.2.1 20201203 (Alpine 10.2.1_pre1) 
built with OpenSSL 1.1.1o  3 May 2022
TLS SNI support enabled
configure arguments: --with-cc-opt=-static --with-ld-opt=-static --with-cpu-opt=generic --sbin-path=/bin/nginx --conf-path=/etc/nginx/nginx.conf --pid-path=/tmp/nginx.pid --http-log-path=/dev/stdout --error-log-path=/dev/stderr --http-client-body-temp-path=/tmp/client_temp --http-fastcgi-temp-path=/tmp/fastcgi_temp --http-proxy-temp-path=/tmp/proxy_temp --http-scgi-temp-path=/tmp/scgi_temp --http-uwsgi-temp-path=/tmp/uwsgi_temp --with-select_module --with-poll_module --with-threads --with-file-aio --with-http_ssl_module --with-http_v2_module --with-http_realip_module --with-http_addition_module --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_auth_request_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_slice_module --with-http_stub_status_module --with-mail --with-mail_ssl_module --with-stream --with-stream_ssl_module --with-stream_realip_module --with-stream_ssl_preread_module --with-compat --with-openssl=/tmp/openssl-1.1.1o --with-zlib=/tmp/zlib-1.2.12
[root@5c53533b458e bin]# cd ..
[root@5c53533b458e rootfs]# find
.
./bin
./bin/nginx
./etc
./etc/group
./etc/nginx
./etc/passwd
./etc/ssl
./etc/ssl/certs
./etc/ssl/certs/ca-certificates.crt
./tmp
[root@5c53533b458e rootfs]#
```

## relativePath Compile

```bash
[root@5de44215a034 sbin]# ./nginx  -V
nginx version: nginx/1.23.0
built by gcc 10.2.1 20201203 (Alpine 10.2.1_pre1) 
built with OpenSSL 1.1.1o  3 May 2022
TLS SNI support enabled
configure arguments: --with-cc-opt=-static --with-ld-opt=-static --with-cpu-opt=generic --prefix=../../nginx --http-client-body-temp-path=./temp/client_temp --http-fastcgi-temp-path=./temp/fastcgi_temp --http-proxy-temp-path=./temp/proxy_temp --http-scgi-temp-path=./temp/scgi_temp --http-uwsgi-temp-path=./temp/uwsgi_temp --with-select_module --with-poll_module --with-threads --with-file-aio --with-http_ssl_module --with-http_v2_module --with-http_realip_module --with-http_addition_module --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_auth_request_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_slice_module --with-http_stub_status_module --with-mail --with-mail_ssl_module --with-stream --with-stream_ssl_module --with-stream_realip_module --with-stream_ssl_preread_module --with-compat --with-openssl=/tmp/openssl-1.1.1o --with-zlib=/tmp/zlib-1.2.12


```