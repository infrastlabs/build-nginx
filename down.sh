
##1.22.0###################
# VERSION="1.23.0"
# CHECKSUM="820acaa35b9272be9e9e72f6defa4a5f2921824709f8aa4772c78ab31ed94cd1"
# hls,mp4_fix: http://nginx.org/download/patch.2022.mp4.txt
VERSION="1.22.0"
CHECKSUM="b33d569a6f11a01433a57ce17e83935e953ad4dc77cdd4d40f896c88ac26eb53"
OPENSSL_VERSION="1.1.1o"
OPENSSL_CHECKSUM="9384a2b0570dd80358841464677115df785edb941c71211f75076d72fe6b438f"
ZLIB_VERSION="1.2.12"
ZLIB_CHECKSUM="91844808532e5ce316b3c010929493c0244f3d37593afd6de04f71821d5136d9"

##1.26.x###################
# VERSION="1.25.5"
# CHECKSUM="2fe2294f8af4144e7e842eaea884182a84ee7970e11046ba98194400902bbec0"
# https://nginx.org/news.html
VERSION="1.26.2"
CHECKSUM="627fe086209bba80a2853a0add9d958d7ebbdffa1a8467a5784c9a6b4f03d738"
OPENSSL_VERSION="3.2.1"
OPENSSL_CHECKSUM="83c7329fe52c850677d75e5d0b0ca245309b97e8ecbcfdc1dfdc4ab9fac35b39"
ZLIB_VERSION="1.3.1"
ZLIB_CHECKSUM="9a93b2b7dfdac77ceba5a558a580e74667dd6fede4585b91eefb60f03b72df23"


ADD="curl -fSL -k"; mkdir -p data/$VERSION
f=data/$VERSION/nginx.tar.gz; test ! -s $f && $ADD https://nginx.org/download/nginx-$VERSION.tar.gz > $f
f=data/$VERSION/openssl.tar.gz; test ! -s $f && $ADD https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz > $f
f=data/$VERSION/zlib.tar.gz; test ! -s $f && $ADD https://zlib.net/zlib-$ZLIB_VERSION.tar.gz > $f
echo """
VERSION=$VERSION
OPENSSL_VERSION=$OPENSSL_VERSION
ZLIB_VERSION=$ZLIB_VERSION
"""> data/$VERSION/_version.txt

# validate
test "$(sha256sum data/$VERSION/nginx.tar.gz | awk '{print $1}')" == "$CHECKSUM" || echo "err: nginx.tar.gz"
test "$(sha256sum data/$VERSION/openssl.tar.gz | awk '{print $1}')" == "$OPENSSL_CHECKSUM" || echo "err: openssl.tar.gz"
test "$(sha256sum data/$VERSION/zlib.tar.gz | awk '{print $1}')" == "$ZLIB_CHECKSUM"  || echo "err: zlib.tar.gz"
