# VERSION="1.23.0"
# CHECKSUM="820acaa35b9272be9e9e72f6defa4a5f2921824709f8aa4772c78ab31ed94cd1"
VERSION="1.22.0"
CHECKSUM="b33d569a6f11a01433a57ce17e83935e953ad4dc77cdd4d40f896c88ac26eb53"

OPENSSL_VERSION="1.1.1o"
OPENSSL_CHECKSUM="9384a2b0570dd80358841464677115df785edb941c71211f75076d72fe6b438f"

ZLIB_VERSION="1.2.12"
ZLIB_CHECKSUM="91844808532e5ce316b3c010929493c0244f3d37593afd6de04f71821d5136d9"

ADD="curl -fSL -k"
# $ADD https://nginx.org/download/nginx-$VERSION.tar.gz > data/nginx.tar.gz
# $ADD https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz > data/openssl.tar.gz
# $ADD https://zlib.net/zlib-$ZLIB_VERSION.tar.gz > data/zlib.tar.gz

# validate
test "$(sha256sum data/nginx.tar.gz | awk '{print $1}')" == "$CHECKSUM" || echo "err: nginx.tar.gz"
test "$(sha256sum data/openssl.tar.gz | awk '{print $1}')" == "$OPENSSL_CHECKSUM" || echo "err: openssl.tar.gz"
test "$(sha256sum data/zlib.tar.gz | awk '{print $1}')" == "$ZLIB_CHECKSUM"  || echo "err: zlib.tar.gz"