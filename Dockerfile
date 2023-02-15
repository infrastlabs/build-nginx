# FROM alpine:3 AS build #alpine镜像make报Operation not permitted https://blog.csdn.net/u014595589/article/details/118693759
FROM alpine:3.13 AS build

# ARG VERSION="1.23.0"
# mainline > stableVer
ARG VERSION="1.22.0"
ARG CHECKSUM="820acaa35b9272be9e9e72f6defa4a5f2921824709f8aa4772c78ab31ed94cd1"

ARG OPENSSL_VERSION="1.1.1o"
ARG OPENSSL_CHECKSUM="9384a2b0570dd80358841464677115df785edb941c71211f75076d72fe6b438f"

ARG ZLIB_VERSION="1.2.12"
ARG ZLIB_CHECKSUM="91844808532e5ce316b3c010929493c0244f3d37593afd6de04f71821d5136d9"

# aliyun.com
RUN domain="mirrors.ustc.edu.cn"; \
echo "http://$domain/alpine/v3.13/main" > /etc/apk/repositories; \
echo "http://$domain/alpine/v3.13/community" >> /etc/apk/repositories
RUN apk add build-base ca-certificates gcc linux-headers pcre-dev perl 

# ADD https://nginx.org/download/nginx-$VERSION.tar.gz /tmp/nginx.tar.gz
# ADD https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz /tmp/openssl.tar.gz
# ADD https://zlib.net/zlib-$ZLIB_VERSION.tar.gz /tmp/zlib.tar.gz
# ADD: 会解压tar.gz
COPY ./data/* /data/
RUN ls -l /data/*; \
    tar -C /tmp -xf /data/nginx.tar.gz && \
    tar -C /tmp -xf /data/openssl.tar.gz && \
    tar -C /tmp -xf /data/zlib.tar.gz && \
    cd /tmp/nginx-$VERSION && \
      # https://blog.51cto.com/65147718/1858474?utm_source=debugrun
      # #CFLAGS=”$CFLAGS -g” (注释掉这行,去掉 debug 模式编译,编译以后程序只有几百 k)
      # cat auto/cc/gcc |grep CFLAGS; \
      # sbin/nginx: 13M  > 5.9M
      sed -i "s^CFLAGS\=\"\$CFLAGS\ \-g\"^#CFLAGS=\"\$CFLAGS \-g\"^g" auto/cc/gcc; \
      ./configure \
        --with-cc-opt="-static" \
        --with-ld-opt="-static" \
        --with-cpu-opt="generic" \
        \
        # /opt/svr/xxxx-sys/nginx/sbin/nginx
        --prefix=../../nginx \
        # --sbin-path="/bin/nginx" \
        # --conf-path="/etc/nginx/nginx.conf" \
        # --pid-path="/tmp/nginx.pid" \
        # --http-log-path="/dev/stdout" \
        # --error-log-path="/dev/stderr" \
        \
        --http-client-body-temp-path="./temp/client_temp" \
        --http-fastcgi-temp-path="./temp/fastcgi_temp" \
        --http-proxy-temp-path="./temp/proxy_temp" \
        --http-scgi-temp-path="./temp/scgi_temp" \
        --http-uwsgi-temp-path="./temp/uwsgi_temp" \
        \
        # http://www.ttlsa.com/nginx/nginx-configure-descriptions/
        # https://blog.csdn.net/netlai/article/details/80016712
        # 启用select模块支持（一种轮询模式,不推荐在高载环境下使用）禁用：--without-select_module
        --with-select_module \
        # 启用poll模块支持（功能与select相同，与select特性相同，为一种轮询模式,不推荐在高载环境下使用）
        --with-poll_module \
        # Enables NGINX to use thread pools.
        --with-threads \
        # 启用file aio支持（一种APL文件传输格式）
        --with-file-aio \
        # 启用ngx_http_ssl_module支持（使支持https请求，需已安装openssl）
        --with-http_ssl_module \
        # Provides support for HTTP/2.
        --with-http_v2_module \
        # 启用ngx_http_realip_module支持（这个模块允许从请求标头更改客户端的IP地址值，默认为关）
        --with-http_realip_module \
        # 启用ngx_http_addition_module支持（作为一个输出过滤器，支持不完全缓冲，分部分响应请求）
        --with-http_addition_module \
        # 启用ngx_http_xslt_module支持（过滤转换XML请求）
        # --with-http_xslt_module \
        # 启用ngx_http_image_filter_module支持（传输JPEG/GIF/PNG 图片的一个过滤器）（默认为不启用。gd库要用到）
        # --with-http_image_filter_module \
        # 启用ngx_http_geoip_module支持（该模块创建基于与MaxMind GeoIP二进制文件相配的客户端IP地址的ngx_http_geoip_module变量）
        # --with-http_geoip_module \
        # 启用ngx_http_sub_module支持（允许用一些其他文本替换nginx响应中的一些文本）
        --with-http_sub_module \
        # 启用ngx_http_dav_module支持（增加PUT,DELETE,MKCOL：创建集合,COPY和MOVE方法）默认情况下为关闭，需编译开启
        --with-http_dav_module \
        # 启用ngx_http_flv_module支持（提供寻求内存使用基于时间的偏移量文件）
        --with-http_flv_module \
        # --with-mp4_module: Provides pseudo-streaming server-side support for MP4 files. 
        --with-http_mp4_module \
        # Decompresses responses with Content-Encoding: gzip for clients that do not support zip encoding method.
        --with-http_gunzip_module \
        # 启用ngx_http_gzip_static_module支持（在线实时压缩输出数据流）
        --with-http_gzip_static_module \
        # Implements client authorization based on the result of a subrequest.
        --with-http_auth_request_module \
        # 启用ngx_http_random_index_module支持（从目录中随机挑选一个目录索引）
        --with-http_random_index_module \
        # 启用ngx_http_secure_link_module支持（计算和检查要求所需的安全链接网址）
        --with-http_secure_link_module \
        # 启用ngx_http_degradation_module支持（允许在内存不足的情况下返回204或444码）
        --with-http_degradation_module \
        # Allows splitting a request into subrequests, each subrequest returns a certain range of response.
        --with-http_slice_module \
        # 启用ngx_http_stub_status_module支持（获取nginx自上次启动以来的工作状态）
        --with-http_stub_status_module \
        # 启用ngx_http_perl_module支持（该模块使nginx可以直接使用perl或通过ssi调用perl）
        # --with-http_perl_module \
        # 启用POP3/IMAP4/SMTP代理模块支持
        --with-mail \
        # 启用ngx_mail_ssl_module支持
        --with-mail_ssl_module \
        # Enables the TCP proxy functionality. 
        --with-stream \
        # Provides support for a stream proxy server to work with the SSL/TLS protocol. 
        --with-stream_ssl_module \
        --with-stream_realip_module \
        # --with-stream_geoip_module \
        --with-stream_ssl_preread_module \
        --with-compat \
        --with-openssl="/tmp/openssl-$OPENSSL_VERSION" \
        --with-zlib="/tmp/zlib-$ZLIB_VERSION" && \
      # find objs && sleep 10; \
      # https://www.cainiao.io/archives/697
      # CFLAGS =  -pipe  -O -W -Wall -Wpointer-arith -Wno-unused-parameter -Werror -g
      # CFLAGS =  -pipe  -O -W -Wall -Wpointer-arith -Wno-unused-parameter -Werror -static
      # cat objs/Makefile |grep "Wno-unused-parameter"; sleep 10; \
      make

# RUN mkdir -p /rootfs/bin && \
#       cp /tmp/nginx-$VERSION/objs/nginx /rootfs/bin/ && \
#     mkdir -p /rootfs/etc && \
#       echo "nogroup:*:10000:nobody" > /rootfs/etc/group && \
#       echo "nobody:*:10000:10000:::" > /rootfs/etc/passwd && \
#     mkdir -p /rootfs/etc/nginx && \
#     mkdir -p /rootfs/etc/ssl/certs && \
#       cp /etc/ssl/certs/ca-certificates.crt /rootfs/etc/ssl/certs/ && \
#     mkdir -p /rootfs/tmp
COPY ./rootfs /rootfs
# ADD ./rootfs/nginx/conf/conf.tar.gz /rootfs/nginx/conf/
# TODO drop: ./temp/client_temp/.gitkeep
RUN \
  find /rootfs  -name ".gitkeep" -exec rm -rf {} \;; \
  find /rootfs; \
  cp /tmp/nginx-$VERSION/objs/nginx /rootfs/nginx/sbin/


# FROM scratch
# FROM infrastlabs/alpine-ext:weak
# for x64/arm64
FROM alpine:3.13

COPY --from=build --chown=10000:10000 /rootfs /rootfs
WORKDIR /rootfs/nginx
# USER 10000:10000
# ENTRYPOINT ["bash"]
# CMD ["-g", "daemon off;"]
CMD ["/rootfs/nginx/start.sh"]
