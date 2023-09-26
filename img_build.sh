
cur=$(cd "$(dirname "$0")"; pwd)
cd $cur

#echo "export DOCKER_REGISTRY_USER_sdsir=xxx" >> /etc/profile
#echo "export DOCKER_REGISTRY_PW_sdsir=xxx" >> /etc/profile

source /etc/profile
export |grep DOCKER_REG
repo=registry.cn-shenzhen.aliyuncs.com
echo "${DOCKER_REGISTRY_PW_infrastSubUser2}" |docker login --username=${DOCKER_REGISTRY_USER_infrastSubUser2} --password-stdin $repo
test -z "$(uname -a |grep aarch64)" && arch=x64 || arch=arm64


ns=infrastlabs
# cache="--no-cache"
# pull="--pull"
ver=latest-echo #02: +full; 04: bins;
img="build-nginx:$arch-$ver"

docker build $cache $pull -t $repo/$ns/$img -f Dockerfile . 
docker push $repo/$ns/$img
